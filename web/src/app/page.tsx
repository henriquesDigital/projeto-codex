const cards = [
  'Automações',
  'Palavras-chave',
  'Etapas da conversa',
  'Leads capturados',
  'Histórico de mensagens'
];

export default function HomePage() {
  return (
    <div className="space-y-6">
      <header>
        <h1 className="text-3xl font-bold">Painel Instagram Automation</h1>
        <p className="text-slate-300">Central visual estilo ManyChat usando n8n + Supabase + APIs oficiais da Meta.</p>
      </header>

      <section className="grid gap-4 md:grid-cols-3">
        {cards.map((title) => (
          <article key={title} className="rounded-lg border border-slate-700 bg-slate-900 p-4">
            <h2 className="text-lg font-semibold">{title}</h2>
            <p className="text-sm text-slate-300">CRUD com Supabase para gerenciar regras sem editar o workflow n8n.</p>
          </article>
        ))}
      </section>

      <section className="rounded-lg border border-slate-700 bg-slate-900 p-4">
        <h2 className="mb-2 text-xl font-semibold">Fluxo exemplo</h2>
        <ol className="list-decimal space-y-2 pl-5 text-sm text-slate-200">
          <li>Gatilho: comentário contém <strong>catálogo</strong>.</li>
          <li>Pergunta automática sobre uso próprio ou revenda.</li>
          <li>Se revenda: pede WhatsApp e envia abordagem de atacado.</li>
          <li>Se uso próprio: envia CTA para WhatsApp no varejo.</li>
        </ol>
      </section>
    </div>
  );
}
