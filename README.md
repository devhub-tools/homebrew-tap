# devhub-tools/homebrew-tap

```bash
brew install devhub-tools/tap/querydesk
```

| Cask        | What it is                                                                     |
| ----------- | ------------------------------------------------------------------------------ |
| `querydesk` | [QueryDesk CLI](https://github.com/devhub-tools/querydesk-cli): connect Postgres and MySQL clients to QueryDesk over HTTPS |

The tap updates itself: the [QueryDesk CLI workflow](.github/workflows/querydesk.yml) checks the CLI's latest release every hour and rewrites the cask when it changes. To pick up a release right away, run it from the Actions tab or with `gh workflow run querydesk.yml --repo devhub-tools/homebrew-tap`.
