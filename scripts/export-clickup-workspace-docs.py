#!/usr/bin/env python3
"""Export ClickUp Doc pages to Markdown files (API v3). Auth: keyring (clickup-cli) or CLICKUP_API_TOKEN."""
from __future__ import annotations

import json
import os
import re
import time
import urllib.error
import urllib.request
from pathlib import Path
from typing import Any

WORKSPACE = "459857"
API = f"https://api.clickup.com/api/v3/workspaces/{WORKSPACE}"


def _auth_token() -> str:
    t = os.environ.get("CLICKUP_API_TOKEN", "").strip()
    if t:
        return t
    try:
        import keyring

        t = keyring.get_password("clickup-cli", "api_token")
    except Exception:
        t = None
    if t:
        return t
    raise SystemExit("Set CLICKUP_API_TOKEN or run: clickup auth login")


def _get(path: str, token: str) -> Any:
    req = urllib.request.Request(
        f"{API}{path}",
        headers={"Authorization": token},
    )
    with urllib.request.urlopen(req, timeout=120) as r:
        return json.loads(r.read().decode())


def _slug(s: str, max_len: int = 64) -> str:
    s = re.sub(r"[^a-zA-Z0-9._-]+", "-", s.strip().lower())
    s = re.sub(r"-+", "-", s).strip("-")
    return (s or "page")[:max_len]


def _walk(node: dict[str, Any], prefix: str) -> list[tuple[str, str, str | None]]:
    """Return list of (breadcrumbs, page_id, parent_page_id)."""
    out: list[tuple[str, str, str | None]] = []
    name = node.get("name") or "untitled"
    path = f"{prefix} / {name}" if prefix else name
    out.append((path, node["id"], node.get("parent_page_id")))
    for ch in node.get("pages") or []:
        out.extend(_walk(ch, path))
    return out


def _flatten_listing(listing: list) -> list[tuple[str, str, str | None]]:
    all_rows: list[tuple[str, str, str | None]] = []
    for root in listing or []:
        all_rows.extend(_walk(root, ""))
    return all_rows


def _fetch_page(doc_id: str, page_id: str, token: str) -> dict:
    return _get(f"/docs/{doc_id}/pages/{page_id}", token)


def export_doc(doc_id: str, out_root: Path, token: str, delay: float = 0.12) -> dict[str, Any]:
    doc_meta = _get(f"/docs/{doc_id}", token)
    name = doc_meta.get("name", doc_id)
    listing = _get(f"/docs/{doc_id}/page_listing", token)
    if not isinstance(listing, list):
        listing = []

    safe_dir = f"{doc_id}--{_slug(name, 48)}"
    ddir = out_root / safe_dir
    pdir = ddir / "pages"
    pdir.mkdir(parents=True, exist_ok=True)

    rows = _flatten_listing(listing)
    page_index: list[dict[str, Any]] = []
    for i, (breadcrumbs, page_id, parent) in enumerate(rows, 1):
        if delay and i > 1:
            time.sleep(delay)
        data = _fetch_page(doc_id, page_id, token)
        content = data.get("content") or ""
        title = data.get("name", page_id)
        pslug = _slug(f"{breadcrumbs}--{page_id}", 100)
        # page_id prefix guarantees unique filenames (ClickUp slugs can collide)
        fname = f"{page_id}__{pslug}.md"
        fpath = pdir / fname
        view_url = f"https://example.com/work-tracker
        header = f"""---
clickup_doc_id: {doc_id}
clickup_page_id: {page_id}
title: {json.dumps(title)}
breadcrumbs: {json.dumps(breadcrumbs)}
parent_page_id: {json.dumps(parent)}
view_url: {json.dumps(view_url)}
---

# {title}

**Path:** {breadcrumbs}

**Canonical page:** {view_url}

---

"""
        fpath.write_text(header + content, encoding="utf-8")
        page_index.append(
            {
                "page_id": page_id,
                "breadcrumbs": breadcrumbs,
                "title": title,
                "file": str(fpath.relative_to(out_root)),
                "view_url": view_url,
            }
        )

    manifest = {
        "doc_id": doc_id,
        "name": name,
        "date_updated": doc_meta.get("date_updated"),
        "doc_url": f"https://example.com/work-tracker
        "page_count": len(rows),
        "pages": page_index,
    }
    (ddir / "meta.json").write_text(json.dumps(manifest, indent=2), encoding="utf-8")
    return manifest


def main() -> None:
    import argparse

    ap = argparse.ArgumentParser()
    ap.add_argument(
        "-o",
        "--output",
        type=Path,
        default=Path("knowledge/clickup-snapshots"),
        help="Output root (e.g. knowledge/clickup-snapshots)",
    )
    ap.add_argument(
        "doc_ids",
        nargs="*",
        default=[
            "e12h-247177",
            "e12h-288937",
            "e12h-289117",
            "e12h-289877",
            "e12h-293437",
            "e12h-293377",
            "e12h-293397",
        ],
    )
    args = ap.parse_args()
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    token = _auth_token()
    summary: list[dict] = []
    for doc_id in args.doc_ids:
        print("Exporting", doc_id, "...", flush=True)
        m = export_doc(doc_id, out, token)
        print("  pages:", m["page_count"], m["name"])
        summary.append(
            {k: m[k] for k in ("doc_id", "name", "page_count", "doc_url") if k in m}
        )
    (out / "EXPORT_SUMMARY.json").write_text(
        json.dumps(summary, indent=2), encoding="utf-8"
    )
    index_lines = [
        "# ClickUp Doc exports",
        "",
        f"Workspace: {WORKSPACE}",
        "",
        "| Doc | Pages | Open in ClickUp |",
        "| --- | --- | --- |",
    ]
    for s in summary:
        index_lines.append(
            f"| {s['name']} | {s['page_count']} | [{s['doc_id']}]({s['doc_url']}) |"
        )
    index_lines.append("")
    (out / "README.md").write_text("\n".join(index_lines), encoding="utf-8")
    print("Wrote", out / "README.md")


if __name__ == "__main__":
    main()
