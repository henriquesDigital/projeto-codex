# Sistema estilo ManyChat para Instagram (n8n + Supabase + Next.js)

## Estrutura
- `web/`: painel administrativo (Next.js + Tailwind + Supabase Auth).
- `supabase/schema.sql`: banco de dados e políticas.
- `n8n-workflows/`: 5 workflows importáveis no n8n.
- `docs/meta-developers-setup.md`: configuração oficial da Meta.
- `.env.example`: variáveis de ambiente.

## Funcionalidades
- Login administrativo via Supabase Auth.
- CRUD de automações, etapas, palavras-chave e respostas.
- Ativação/desativação de automações.
- Gestão de leads, histórico de mensagens e alteração manual de etapa.
- Execução do motor de conversa via n8n com Instagram Graph/Messaging API.

## Banco Supabase
Execute no SQL Editor:
```sql
-- arquivo completo em supabase/schema.sql
```

Tabelas principais:
- `automations`
- `automation_steps`
- `leads`
- `messages`

## Workflows n8n (importar JSON)
1. `01-instagram-comments-webhook.json`
2. `02-instagram-direct-reply-engine.json`
3. `03-instagram-publish-content.json`
4. `04-save-leads.json`
5. `05-fallback-unrecognized.json`

## Instalação

### 1) Supabase
1. Crie projeto no Supabase.
2. Rode `supabase/schema.sql` no SQL Editor.
3. Configure chaves no `.env`.

### 2) Painel web
```bash
cd web
npm install
npm run dev
```

### 3) n8n
1. Suba o n8n (Docker ou cloud).
2. Cadastre credenciais HTTP para Supabase REST e Meta Graph API.
3. Importe os 5 workflows da pasta `n8n-workflows`.
4. Configure as variáveis de ambiente iguais ao `.env.example`.

### 4) Meta Developers
Siga o guia: `docs/meta-developers-setup.md`.

## Exemplo de automação (catálogo)
- Trigger: comentário contém `catálogo`.
- Etapa 1: perguntar "uso próprio ou revenda".
- Etapa 2a (revenda): enviar texto de atacado e pedir WhatsApp.
- Etapa 2b (uso próprio): enviar CTA de WhatsApp varejo.

## Regras de compliance
- Somente APIs oficiais da Meta.
- Sem ManyChat.
- Sem automação de navegador.
- Sem ações de spam (seguir/curtir/DM fria automatizada).
