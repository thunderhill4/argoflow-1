Steps for Grafana user integrations

1. Configure Grafana Proxy auth and set header to `kubeflow-userid`
2. Force create OAuth user using API
  - curl -i -H "kubeflow-userid: test@kubeflow.org" https://grafana.abs-cloud.nl/grafana
3. Get user ID using HTTP
  - curl https://admin:password@grafana.abs-cloud.nl/grafana/api/users/lookup?loginOrEmail=test@kubeflow.org
4. Create folder for the namespace
  - curl -X POST -H "Content-Type: application/json" -d '{"uid": "test-user", "title": "Namespace test-user"}' https://admin:password@grafana.abs-cloud.nl/grafana/api/folders
5. Update folder permissions so only Admin and the user can access the folder (how to handle namespace sharing?)
    - curl -X POST -H "Content-Type: application/json" -d '{"items":[{"userId": 7, "permission": 1}]}' https://admin:password@grafana.abs-cloud.nl/grafana/api/folders/test-user/permissions

Edit dashboard configmap(s) and deploy

1. Change configmap annotation for the namespace folder (title)
2. Change dashboard UID(s) to prepend or append the namespace
3. Where needed, change the `namespace` constant to the namespace (how to handle namespace sharing?)
4. Deploy the configmap(s) to the monitoring namespace
