# Passo a passo no Meta Developers

1. Acesse https://developers.facebook.com/ e crie um App do tipo **Business**.
2. Adicione os produtos **Instagram Graph API**, **Webhooks** e **Facebook Login for Business**.
3. Conecte uma página Facebook a uma conta Instagram Business.
4. Gere token de página de longa duração com permissões:
   - `instagram_basic`
   - `instagram_manage_messages`
   - `pages_manage_metadata`
   - `pages_read_engagement`
   - `pages_manage_posts`
5. Configure Webhooks da página:
   - Callback URL: `https://SEU_N8N/webhook/instagram/direct`
   - Verify token: mesmo valor de `META_VERIFY_TOKEN`
   - Campos: `messages`, `messaging_postbacks`, `comments`.
6. No Instagram, habilite "Permitir acesso a mensagens" no app conectado.
7. Faça subscribe da página no app via Graph API Explorer.
8. Teste o webhook enviando DM para a conta e validando no n8n.
