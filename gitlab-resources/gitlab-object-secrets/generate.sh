#!/bin/bash

# edit gitlab artifact storage config and create secret
export artifacts_aws_access_key_id=$(kubectl -n gitlab get secret gitlab-artifacts-storage -ojsonpath='{.data.AWS_ACCESS_KEY_ID}' | base64 --decode ; echo)
export artifacts_aws_secret_access_key=$(kubectl -n gitlab get secret gitlab-artifacts-storage -ojsonpath='{.data.AWS_SECRET_ACCESS_KEY}' | base64 --decode ; echo)
# yq eval -i ".aws_access_key_id = \"${artifacts_aws_access_key_id}\" | .aws_secret_access_key = \"$artifacts_aws_secret_access_key\"" artifact.s3.yaml
# kubectl create secret -n gitlab generic objectstore-artifacts --from-file=connection=artifact.s3.yaml
yq eval ".aws_access_key_id = \"${artifacts_aws_access_key_id}\" | .aws_secret_access_key = \"${artifacts_aws_secret_access_key}\"" template.yaml | kubectl create secret generic -n gitlab objectstore-artifacts --dry-run=client --from-file=connection=/dev/stdin -o yaml | kubeseal | yq eval -P > artifact-s3.yaml

# edit gitlab backup storage config and create secret
export backup_aws_access_key_id=$(kubectl -n gitlab get secret gitlab-backup-storage -ojsonpath='{.data.AWS_ACCESS_KEY_ID}' | base64 --decode ; echo)
export backup_aws_secret_access_key=$(kubectl -n gitlab get secret gitlab-backup-storage -ojsonpath='{.data.AWS_SECRET_ACCESS_KEY}' | base64 --decode ; echo)
# yq eval -i ".aws_access_key_id = \"$backup_aws_access_key_id\" | .aws_secret_access_key = \"$backup_aws_secret_access_key\"" backup.s3.yaml
# kubectl create secret -n gitlab generic objectstore-backup --from-file=config=backup.s3.yaml
yq eval ".aws_access_key_id = \"${backup_aws_access_key_id}\" | .aws_secret_access_key = \"${backup_aws_secret_access_key}\"" template.yaml | kubectl create secret generic -n gitlab objectstore-backup --dry-run=client --from-file=config=/dev/stdin -o yaml | kubeseal | yq eval -P > backup-s3.yaml

# edit gitlab dependency_proxy storage config and create secret
export dependency_proxy_aws_access_key_id=$(kubectl -n gitlab get secret gitlab-dependency-proxy-storage -ojsonpath='{.data.AWS_ACCESS_KEY_ID}' | base64 --decode ; echo)
export dependency_proxy_aws_secret_access_key=$(kubectl -n gitlab get secret gitlab-dependency-proxy-storage -ojsonpath='{.data.AWS_SECRET_ACCESS_KEY}' | base64 --decode ; echo)
# yq eval -i ".aws_access_key_id = \"$dependency_proxy_aws_access_key_id\" | .aws_secret_access_key = \"$dependency_proxy_aws_secret_access_key\"" dependency-proxy.s3.yaml
# kubectl create secret -n gitlab generic objectstore-dependency-proxy --from-file=connection=dependency-proxy.s3.yaml
yq eval ".aws_access_key_id = \"${dependency_proxy_aws_access_key_id}\" | .aws_secret_access_key = \"${dependency_proxy_aws_secret_access_key}\"" template.yaml | kubectl create secret generic -n gitlab objectstore-dependency-proxy --dry-run=client --from-file=connection=/dev/stdin -o yaml | kubeseal | yq eval -P > dependency-proxy-s3.yaml

# edit gitlab lfs storage config and create secret
export lfs_aws_access_key_id=$(kubectl -n gitlab get secret gitlab-lfs-storage -ojsonpath='{.data.AWS_ACCESS_KEY_ID}' | base64 --decode ; echo)
export lfs_aws_secret_access_key=$(kubectl -n gitlab get secret gitlab-lfs-storage -ojsonpath='{.data.AWS_SECRET_ACCESS_KEY}' | base64 --decode ; echo)
# yq eval -i ".aws_access_key_id = \"$lfs_aws_access_key_id\" | .aws_secret_access_key = \"$lfs_aws_secret_access_key\"" lfs.s3.yaml
# kubectl create secret -n gitlab generic objectstore-lfs --from-file=connection=lfs.s3.yaml
yq eval ".aws_access_key_id = \"${lfs_aws_access_key_id}\" | .aws_secret_access_key = \"${lfs_aws_secret_access_key}\"" template.yaml | kubectl create secret generic -n gitlab objectstore-lfs --dry-run=client --from-file=connection=/dev/stdin -o yaml | kubeseal | yq eval -P > lfs-s3.yaml

# edit gitlab mr_diffs storage config and create secret
export mr_diffs_aws_access_key_id=$(kubectl -n gitlab get secret gitlab-mr-diffs-storage -ojsonpath='{.data.AWS_ACCESS_KEY_ID}' | base64 --decode ; echo)
export mr_diffs_aws_secret_access_key=$(kubectl -n gitlab get secret gitlab-mr-diffs-storage -ojsonpath='{.data.AWS_SECRET_ACCESS_KEY}' | base64 --decode ; echo)
# yq eval -i ".aws_access_key_id = \"$mr_diffs_aws_access_key_id\" | .aws_secret_access_key = \"$mr_diffs_aws_secret_access_key\"" mr-diffs.s3.yaml
# kubectl create secret -n gitlab generic objectstore-mr-diffs --from-file=connection=mr-diffs.s3.yaml
yq eval ".aws_access_key_id = \"${mr_diffs_aws_access_key_id}\" | .aws_secret_access_key = \"${mr_diffs_aws_secret_access_key}\"" template.yaml | kubectl create secret generic -n gitlab objectstore-mr-diffs --dry-run=client --from-file=connection=/dev/stdin -o yaml | kubeseal | yq eval -P > mr-diffs-s3.yaml


# edit gitlab packages storage config and create secret
export packages_aws_access_key_id=$(kubectl -n gitlab get secret gitlab-packages-storage -ojsonpath='{.data.AWS_ACCESS_KEY_ID}' | base64 --decode ; echo)
export packages_aws_secret_access_key=$(kubectl -n gitlab get secret gitlab-packages-storage -ojsonpath='{.data.AWS_SECRET_ACCESS_KEY}' | base64 --decode ; echo)
# yq eval -i ".aws_access_key_id = \"$packages_aws_access_key_id\" | .aws_secret_access_key = \"$packages_aws_secret_access_key\"" packages.s3.yaml
# kubectl create secret -n gitlab generic objectstore-packages --from-file=connection=packages.s3.yaml
yq eval ".aws_access_key_id = \"${packages_aws_access_key_id}\" | .aws_secret_access_key = \"${packages_aws_secret_access_key}\"" template.yaml | kubectl create secret generic -n gitlab objectstore-packages --dry-run=client --from-file=connection=/dev/stdin -o yaml | kubeseal | yq eval -P > packages-s3.yaml

# edit gitlab registry storage config and create secret
export registry_aws_access_key_id=$(kubectl -n gitlab get secret gitlab-registry-storage -ojsonpath='{.data.AWS_ACCESS_KEY_ID}' | base64 --decode ; echo)
export registry_aws_secret_access_key=$(kubectl -n gitlab get secret gitlab-registry-storage -ojsonpath='{.data.AWS_SECRET_ACCESS_KEY}' | base64 --decode ; echo)
# yq eval -i ".s3.accesskey = \"$registry_aws_access_key_id\" | .s3.secretkey = \"$registry_aws_secret_access_key\"" registry.s3.yaml
# kubectl create secret -n gitlab generic registry-storage --from-file=config=registry.s3.yaml
yq eval ".s3.accesskey = \"${registry_aws_access_key_id}\" | .s3.secretkey = \"${registry_aws_secret_access_key}\"" registry-template.yaml | kubectl create secret generic -n gitlab registry-storage --dry-run=client --from-file=config=/dev/stdin -o yaml | kubeseal | yq eval -P > registry-s3.yaml

# edit gitlab terraform_state storage config and create secret
export terraform_state_aws_access_key_id=$(kubectl -n gitlab get secret gitlab-terraform-state-storage -ojsonpath='{.data.AWS_ACCESS_KEY_ID}' | base64 --decode ; echo)
export terraform_state_aws_secret_access_key=$(kubectl -n gitlab get secret gitlab-terraform-state-storage -ojsonpath='{.data.AWS_SECRET_ACCESS_KEY}' | base64 --decode ; echo)
# yq eval -i ".aws_access_key_id = \"$terraform_state_aws_access_key_id\" | .aws_secret_access_key = \"$terraform_state_aws_secret_access_key\"" terraform-state.s3.yaml
# kubectl create secret -n gitlab generic objectstore-terraform-state --from-file=connection=terraform-state.s3.yaml
yq eval ".aws_access_key_id = \"${terraform_state_aws_access_key_id}\" | .aws_secret_access_key = \"${terraform_state_aws_secret_access_key}\"" template.yaml | kubectl create secret generic -n gitlab objectstore-terraform-state --dry-run=client --from-file=connection=/dev/stdin -o yaml | kubeseal | yq eval -P > terraform-state-s3.yaml

# edit gitlab uploads storage config and create secret
export uploads_aws_access_key_id=$(kubectl -n gitlab get secret gitlab-uploads-storage -ojsonpath='{.data.AWS_ACCESS_KEY_ID}' | base64 --decode ; echo)
export uploads_aws_secret_access_key=$(kubectl -n gitlab get secret gitlab-uploads-storage -ojsonpath='{.data.AWS_SECRET_ACCESS_KEY}' | base64 --decode ; echo)
# yq eval -i ".aws_access_key_id = \"$uploads_aws_access_key_id\" | .aws_secret_access_key = \"$uploads_aws_secret_access_key\"" uploads.s3.yaml
# kubectl create secret -n gitlab generic objectstore-uploads --from-file=connection=uploads.s3.yaml
yq eval ".aws_access_key_id = \"${uploads_aws_access_key_id}\" | .aws_secret_access_key = \"${uploads_aws_secret_access_key}\"" template.yaml | kubectl create secret generic -n gitlab objectstore-uploads --dry-run=client --from-file=connection=/dev/stdin -o yaml | kubeseal | yq eval -P > uploads-s3.yaml
