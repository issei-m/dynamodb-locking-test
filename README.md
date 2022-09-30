# dynamodb-locking-test

https://engineering.mobalab.net/2022/09/30/dynamodb-locking/

```
docker build -t dynamodb-locking .
docker run -it --rm dynamodb-locking 
```

In the bash:

```
bash-5.1$ ./lock_test.rb
```

(!) Requires to expose the credential for your AWS account that hosts the DynamoDB table to this container before you go. (e.g. via `AWS_*` environment variables)
