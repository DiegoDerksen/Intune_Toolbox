I'll be showing you how to make reporting from Microsoft Defender for Endpoint alerts to an Excel sheet through Power Automate and/or Logic App. This will create insight for whatever happens in your environment

# Prerequisites:
Power Automate Premium (for HTTP connector)
App registration in Azure with the following permission:
Graph API > SecurityAlert.Read.All (Application)

# Make a App Registration in Azure
1. Go to Azure.com
2. Click on Azure Active Directory
3. Click on App Registration
4. Click on New Registration
5. Create a new name and click on Register
6. After the app has been created go to API Permissions
7. Click on Add a Permission
8. Select Microsoft Graph and select Application Permissions
9. Look up the following permission SecurityAlert.Read.All and add this to the application followed up by granting admin consent

## Create a client secret
1. Go to your newly created app
2. Certificates & Secrets
3. Click on New Client Secret
4. Set a description and expiry to your liking
5. Copy the value of the secret, you **won't** be able to see this after you close this window

# Make the flow:
1. I've made a recurrent flow so it runs every Monday at 10 AM.
2. We need to initialize 4 variables so it can use the app registration in Azure
   
| Name Variable | Name  | Type  | Value  |
| ------------ | ------------ | ------------ | ------------ |
| Initialize TenantID | TenantID | String | {Paste your Tenant ID} |
| Initialize ClientID | ClientID | String | {Paste your Client ID} |
| Initialize Audience | Audience | String | https://graph.microsoft.com |
| Initialize Secret |  Secret | String | {Paste your Secret} |

Your flow should look something like this:
![image](https://github.com/DiegoDerksen/Intune_Toolbox/assets/144729242/8e149a32-bfe6-4599-93ae-dc8a17361140)

3. Make a new step with a HTTP connector with the following settings:
Method: Get
URI: `https://graph.microsoft.com/v1.0/security/alerts_v2?$filter=servicesource+eq+'microsoftDefenderForEndpoint'+and+createdDateTime+ge+@{formatDateTime(subtractFromTime(utcNow(), 7, 'Day'), 'yyyy-MM-ddTHH:mm:ssZ')}`
this URI will get all alerts from Microsoft Defender for Endpoint in the last 7 days

Authentication: Active Directory OAuth

Put in the variables from step 2 inside Tenant, Audience, Client ID and Secret

The step should look like this:

![firefox_M2nd8aIXBx](https://github.com/DiegoDerksen/Intune_Toolbox/assets/144729242/170d4be2-5598-4c0a-b1a7-f1b4dfb2ed88)

4. Make a new step with a Parse JSON variable
Content should be: Body
Schema:
`{
    "type": "object",
    "properties": {
        "statusCode": {
            "type": "integer"
        },
        "headers": {
            "type": "object",
            "properties": {
                "Transfer-Encoding": {
                    "type": "string"
                },
                "Vary": {
                    "type": "string"
                },
                "Strict-Transport-Security": {
                    "type": "string"
                },
                "request-id": {
                    "type": "string"
                },
                "client-request-id": {
                    "type": "string"
                },
                "x-ms-ags-diagnostic": {
                    "type": "string"
                },
                "OData-Version": {
                    "type": "string"
                },
                "Date": {
                    "type": "string"
                },
                "Content-Type": {
                    "type": "string"
                },
                "Content-Length": {
                    "type": "string"
                }
            }
        },
        "body": {
            "type": "object",
            "properties": {
                "@@odata.context": {
                    "type": "string"
                },
                "value": {
                    "type": "array",
                    "items": {
                        "type": "object",
                        "properties": {
                            "id": {
                                "type": "string"
                            },
                            "providerAlertId": {
                                "type": "string"
                            },
                            "incidentId": {
                                "type": "string"
                            },
                            "status": {
                                "type": "string"
                            },
                            "severity": {
                                "type": "string"
                            },
                            "classification": {},
                            "determination": {},
                            "serviceSource": {
                                "type": "string"
                            },
                            "detectionSource": {
                                "type": "string"
                            },
                            "productName": {
                                "type": "string"
                            },
                            "detectorId": {
                                "type": "string"
                            },
                            "tenantId": {
                                "type": "string"
                            },
                            "title": {
                                "type": "string"
                            },
                            "description": {
                                "type": "string"
                            },
                            "recommendedActions": {
                                "type": "string"
                            },
                            "category": {
                                "type": "string"
                            },
                            "assignedTo": {
                                "type": "string"
                            },
                            "alertWebUrl": {
                                "type": "string"
                            },
                            "incidentWebUrl": {
                                "type": "string"
                            },
                            "actorDisplayName": {},
                            "threatDisplayName": {
                                "type": "string"
                            },
                            "threatFamilyName": {
                                "type": "string"
                            },
                            "mitreTechniques": {
                                "type": "array"
                            },
                            "createdDateTime": {
                                "type": "string"
                            },
                            "lastUpdateDateTime": {
                                "type": "string"
                            },
                            "resolvedDateTime": {
                                "type": "string"
                            },
                            "firstActivityDateTime": {
                                "type": "string"
                            },
                            "lastActivityDateTime": {
                                "type": "string"
                            },
                            "systemTags": {
                                "type": "array"
                            },
                            "alertPolicyId": {},
                            "additionalData": {},
                            "comments": {
                                "type": "array"
                            },
                            "evidence": {
                                "type": "array",
                                "items": {
                                    "type": "object",
                                    "properties": {
                                        "@@odata.type": {
                                            "type": "string"
                                        },
                                        "createdDateTime": {
                                            "type": "string"
                                        },
                                        "verdict": {
                                            "type": "string"
                                        },
                                        "remediationStatus": {
                                            "type": "string"
                                        },
                                        "remediationStatusDetails": {},
                                        "roles": {
                                            "type": "array"
                                        },
                                        "detailedRoles": {
                                            "type": "array",
                                            "items": {
                                                "type": "string"
                                            }
                                        },
                                        "tags": {
                                            "type": "array"
                                        },
                                        "firstSeenDateTime": {
                                            "type": "string"
                                        },
                                        "mdeDeviceId": {
                                            "type": "string"
                                        },
                                        "azureAdDeviceId": {
                                            "type": "string"
                                        },
                                        "deviceDnsName": {
                                            "type": "string"
                                        },
                                        "osPlatform": {
                                            "type": "string"
                                        },
                                        "osBuild": {
                                            "type": "integer"
                                        },
                                        "version": {
                                            "type": "string"
                                        },
                                        "healthStatus": {
                                            "type": "string"
                                        },
                                        "riskScore": {
                                            "type": "string"
                                        },
                                        "rbacGroupId": {
                                            "type": "integer"
                                        },
                                        "rbacGroupName": {},
                                        "onboardingStatus": {
                                            "type": "string"
                                        },
                                        "defenderAvStatus": {
                                            "type": "string"
                                        },
                                        "ipInterfaces": {
                                            "type": "array",
                                            "items": {
                                                "type": "string"
                                            }
                                        },
                                        "vmMetadata": {},
                                        "loggedOnUsers": {
                                            "type": "array"
                                        },
                                        "detectionStatus": {
                                            "type": "string"
                                        },
                                        "fileDetails": {
                                            "type": "object",
                                            "properties": {
                                                "sha1": {
                                                    "type": "string"
                                                },
                                                "sha256": {
                                                    "type": "string"
                                                },
                                                "fileName": {
                                                    "type": "string"
                                                },
                                                "filePath": {
                                                    "type": "string"
                                                },
                                                "fileSize": {
                                                    "type": "integer"
                                                },
                                                "filePublisher": {},
                                                "signer": {},
                                                "issuer": {}
                                            }
                                        }
                                    },
                                    "required": [
                                        "@@odata.type",
                                        "createdDateTime",
                                        "verdict",
                                        "remediationStatus",
                                        "remediationStatusDetails",
                                        "roles",
                                        "detailedRoles",
                                        "tags",
                                        "mdeDeviceId"
                                    ]
                                }
                            }
                        },
                        "required": [
                            "id",
                            "providerAlertId",
                            "incidentId",
                            "status",
                            "severity",
                            "classification",
                            "determination",
                            "serviceSource",
                            "detectionSource",
                            "productName",
                            "detectorId",
                            "tenantId",
                            "title",
                            "description",
                            "recommendedActions",
                            "category",
                            "assignedTo",
                            "alertWebUrl",
                            "incidentWebUrl",
                            "actorDisplayName",
                            "threatDisplayName",
                            "threatFamilyName",
                            "mitreTechniques",
                            "createdDateTime",
                            "lastUpdateDateTime",
                            "resolvedDateTime",
                            "firstActivityDateTime",
                            "lastActivityDateTime",
                            "systemTags",
                            "alertPolicyId",
                            "additionalData",
                            "comments",
                            "evidence"
                        ]
                    }
                }
            }
        }
    }
}`

5. Create a new step with a compose variable, this is to create a clean Excel file.
The input is:
`{
  "$content-type": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  "$content": "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"
}`

6. Create a new step with Create File in Sharepoint

Choose a site address

Choose the folder where you want to create the file

File name should be: Report - Anti Virus Alerts @{formatDateTime(utcNow(), 'dd-MM-yyyy')}.xlsx

File Content: @{outputs('Generate_clean_Excel_file')}

7. Create a new step to create table
Location should be the same location as step 6

Document Library: Documents

File: @outputs('Create_file_in_Sharepoint')?['body/Id']

Table Range: A1:F1

Column names: DeviceName,title,severity,category,status,createdtime

8. Create a Apply to Each step
   Ouput should be: @{body('Parse_JSON')?['value']}
   Create another Apply to Each step inside this, this ouput should be: @{items('Apply_to_each')['evidence']}
9. Create a Add a row into a table step inside Apply to Each 2
Location: Same as in step 6

Document Library: Documents

File: @outputs('Create_file_in_Sharepoint')?['body/Id']

Table: @outputs('Create_table')?['body/name']

Row:
`{
  "DeviceName": @{items('Apply_to_each_2')?['deviceDnsName']},
  "title": @{items('Apply_to_each')?['title']},
  "severity": @{items('Apply_to_each')?['severity']},
  "category": @{items('Apply_to_each')?['category']},
  "status": @{items('Apply_to_each')?['status']},
  "createdtime": @{items('Apply_to_each')?['createdDateTime']}
}
`

It should look like this: 

![firefox_V1U6G5ZOMi](https://github.com/DiegoDerksen/Intune_Toolbox/assets/144729242/2f7436cf-257d-4a67-bd0c-e635b0178c34)


# End result screenshot

![firefox_2ZQqKLk6Dv](https://github.com/DiegoDerksen/Intune_Toolbox/assets/144729242/a5257d80-94c6-4b5c-bff3-5781cf59d575)

