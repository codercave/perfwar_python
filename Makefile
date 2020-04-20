deploy:
	sam build

	sam package --s3-bucket ${CODERCAVE_BUCKET} \
		--output-template-file packaged-template.yaml \
		--force-upload \
		--region eu-central-1 \
		--profile caveman

	$(info [+] Deploying 'codercave-python-test')
	sam deploy \
		--template-file packaged-template.yaml \
		--stack-name codercave-python-test \
		--s3-bucket ${CODERCAVE_BUCKET} \
		--capabilities CAPABILITY_IAM \
		--region eu-central-1 \
		--force-upload \
		--profile caveman

delete:
	aws cloudformation delete-stack \
		--stack-name codercave-python-test \
		--profile caveman