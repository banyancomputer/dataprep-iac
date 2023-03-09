# dataprep-iac: demo

Directory for coordinating the demo of the `dataprep` tool.

## Dependencies
- Python
- Ansible


# Demo Overview
- Setting up the instance
- Setting up the environment and installing dependencies
- Torrenting datasets
- Running the demo
- Opening up NFS server on generated output

## Setting up IFTTT
NOTE (amiller68): When I last tested this, my key did not work at all! Something may have changed with IFTTT.

You can configure `env/env.ifttt` to send you notifications when the benchmark is complete or as it progresses.
You will need to create an IFTTT account and configure a webhook to send notifications to your phone:
- Create an IFTTT account
- Create a new applet
  - Select "Webhooks" as the trigger. Use the "Receive a web request with a JSON payload" trigger. Call this trigger "benchmark-notification"
  - Select "Notifications" as the action. Use the "Send a rich notification from the IFTTT app" action.
- Configure the webhook
  - Go to https://ifttt.com/services/maker_webhooks/settings
  - Copy the key from the URL at the bottom of the page. 
  - Configure `env/env.ifttt` s.t. `IFTTT_TEST_WEBHOOK_KEY=<your key>`
- Download the IFTTT app on your phone