package Cx

import data.generic.common as common_lib
import data.generic.terraform as tf_lib

#default of http_tokens is optional
CxPolicy[result] {
	resource := input.document[i].resource.aws_instance[name]
    metadata_options := resource.metadata_options

	not common_lib.valid_key(metadata_options, "http_tokens")

	result := {
		"documentId": input.document[i].id,
		"resourceType": "aws_instance",
		"resourceName": tf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("resource[%s].metadata_options", [name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": "'http_tokens' should be set to 'required'",
		"keyActualValue": "'http_tokens' is missing",
		"searchLine": common_lib.build_search_line(["resource", "aws_instance", name], []),
		"remediation": "aws_instance = 'required'",
		"remediationType": "addition",
	}
}

CxPolicy[result] {
	resource := input.document[i].resource.aws_instance[name]
    metadata_options := resource.metadata_options
    http_tokens := metadata_options.http_tokens

	http_tokens == "optional"

	result := {
		"documentId": input.document[i].id,
		"resourceType": "aws_instance",
		"resourceName": tf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("resource[%s].metadata_options.http_tokens", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": "'http_tokens' should be set to 'required'",
		"keyActualValue": "'http_tokens' is equal 'optional'",
		"searchLine": common_lib.build_search_line(["resource", "aws_instance", name], []),
		"remediation": json.marshal({
			"before": "optional",
			"after": "required"
		}),
		"remediationType": "replacement",
	}
}