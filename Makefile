IMAGE=358469521612.dkr.ecr.us-east-1.amazonaws.com/relicstaurants:latest
SERVICE_ARN=arn:aws:apprunner:us-east-1:358469521612:service/relicstaurants/8bb5b34972a24a528a47bc0b0e7dfb59

deploy:
	@docker build . -t $(IMAGE)
	@docker push $(IMAGE)
	@aws apprunner start-deployment --service-arn $(SERVICE_ARN)

loadTest:
	@k6 run simulator/loadTest.js

browserTest:
	@node simulator/test.js