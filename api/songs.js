const SUPABASE_URL = process.env.SUPABASE_URL;
const SERVICE_KEY = process.env.SUPABASE_SERVICE_KEY;
const EDIT_PASSWORD = process.env.EDIT_PASSWORD;

function toRow(s) {
  return {
    title: s.title,
    artist: s.artist,
    genre: s.genre,
    tj: s.tj || null,
    ky: s.ky || null,
    mr_url: s.mrUrl || null,
    original_url: s.originalUrl || null,
    lyrics_url: s.lyricsUrl || null,
    lyrics_text: s.lyricsText || null,
    image_url: s.imageUrl || null
  };
}

function fromRow(r) {
  return {
    id: r.id,
    title: r.title,
    artist: r.artist,
    genre: r.genre,
    tj: r.tj || "",
    ky: r.ky || "",
    mrUrl: r.mr_url || "",
    originalUrl: r.original_url || "",
    lyricsUrl: r.lyrics_url || "",
    lyricsText: r.lyrics_text || "",
    imageUrl: r.image_url || ""
  };
}

async function sb(path, opts) {
  opts = opts || {};
  const headers = Object.assign(
    {
      apikey: SERVICE_KEY,
      Authorization: "Bearer " + SERVICE_KEY,
      "Content-Type": "application/json",
      Prefer: opts.prefer || "return=representation"
    },
    opts.headers || {}
  );
  return fetch(SUPABASE_URL + "/rest/v1/" + path, {
    method: opts.method || "GET",
    headers: headers,
    body: opts.body
  });
}

module.exports = async (req, res) => {
  if (!SUPABASE_URL || !SERVICE_KEY || !EDIT_PASSWORD) {
    res.status(500).json({ error: "서버 환경변수(SUPABASE_URL/SUPABASE_SERVICE_KEY/EDIT_PASSWORD)가 설정되지 않았습니다." });
    return;
  }

  try {
    if (req.method === "GET") {
      const r = await sb("songs?select=*&order=created_at.asc");
      const rows = await r.json();
      if (!r.ok) { res.status(r.status).json(rows); return; }
      res.status(200).json(rows.map(fromRow));
      return;
    }

    const body = req.body || {};

    if (req.method === "POST") {
      if (body.password !== EDIT_PASSWORD) { res.status(401).json({ error: "비밀번호가 올바르지 않습니다." }); return; }
      const row = toRow(body);
      row.id = "s-" + Date.now() + "-" + Math.random().toString(36).slice(2, 8);
      const r = await sb("songs", { method: "POST", body: JSON.stringify(row) });
      const data = await r.json();
      if (!r.ok) { res.status(r.status).json(data); return; }
      res.status(200).json(fromRow(data[0]));
      return;
    }

    if (req.method === "PUT") {
      if (body.password !== EDIT_PASSWORD) { res.status(401).json({ error: "비밀번호가 올바르지 않습니다." }); return; }
      if (!body.id) { res.status(400).json({ error: "id가 필요합니다." }); return; }
      const row = toRow(body);
      const r = await sb("songs?id=eq." + encodeURIComponent(body.id), { method: "PATCH", body: JSON.stringify(row) });
      const data = await r.json();
      if (!r.ok) { res.status(r.status).json(data); return; }
      res.status(200).json(fromRow(data[0]));
      return;
    }

    if (req.method === "DELETE") {
      const id = body.id || req.query.id;
      const password = body.password || req.query.password;
      if (password !== EDIT_PASSWORD) { res.status(401).json({ error: "비밀번호가 올바르지 않습니다." }); return; }
      if (!id) { res.status(400).json({ error: "id가 필요합니다." }); return; }
      const r = await sb("songs?id=eq." + encodeURIComponent(id), { method: "DELETE", prefer: "return=minimal" });
      if (!r.ok) { const d = await r.json(); res.status(r.status).json(d); return; }
      res.status(200).json({ ok: true });
      return;
    }

    res.setHeader("Allow", "GET, POST, PUT, DELETE");
    res.status(405).json({ error: "지원하지 않는 메서드입니다." });
  } catch (err) {
    res.status(500).json({ error: String((err && err.message) || err) });
  }
};
