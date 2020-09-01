# ValidatorClient::ValidationApi

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_validators**](ValidationApi.md#get_validators) | **GET** /validators | lists available validators
[**validate**](ValidationApi.md#validate) | **POST** /validators/{validator_id}/validate | performs a validation


# **get_validators**
> Array&lt;Validator&gt; get_validators

lists available validators

Lists all of the available validator pipelines. 

### Example
```ruby
# load the gem
require 'md-validator-client'

api_instance = ValidatorClient::ValidationApi.new

begin
  #lists available validators
  result = api_instance.get_validators
  p result
rescue ValidatorClient::ApiError => e
  puts "Exception when calling ValidationApi->get_validators: #{e}"
end
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Array&lt;Validator&gt;**](Validator.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **validate**
> Array&lt;Status&gt; validate(validator_id, metadata)

performs a validation

### Example
```ruby
# load the gem
require 'md-validator-client'

api_instance = ValidatorClient::ValidationApi.new

validator_id = 'validator_id_example' # String | An identifier for the validation to be performed. 

metadata = 'metadata_example' # String | The metadata to be validated.


begin
  #performs a validation
  result = api_instance.validate(validator_id, metadata)
  p result
rescue ValidatorClient::ApiError => e
  puts "Exception when calling ValidationApi->validate: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **validator_id** | **String**| An identifier for the validation to be performed.  | 
 **metadata** | **String**| The metadata to be validated. | 

### Return type

[**Array&lt;Status&gt;**](Status.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/xml+samlmetadata
 - **Accept**: application/json



