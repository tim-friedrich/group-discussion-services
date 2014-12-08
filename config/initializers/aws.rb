#this should be replaced with enviroment variables for security reasons

AWS.config(access_key_id:     'AKIAIQA2U5XTDLSVYL6Q',
           secret_access_key: 'S8SOEokDNkaqHTbsUjRm/8fJOb9DD6lJSK8iQ85/' )

S3_BUCKET = AWS::S3.new.buckets['group-discussion-services-dev']