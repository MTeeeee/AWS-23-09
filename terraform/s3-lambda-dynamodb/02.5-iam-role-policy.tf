# IAM Rolle wird erstellt
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Zugriff Policy für Rolle
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "lambda-dynamodb" {
  statement {
    effect = "Allow"

    actions = [ 
        "dynamodb:BatchGetItem",
        "dynamodb:BatchWriteItem",
        "dynamodb:ConditionCheckItem",
        "dynamodb:CreateTable",
        "dynamodb:DeleteItem",
        "dynamodb:DescribeTable",
        "dynamodb:GetItem",
        "dynamodb:ListTables",
        "dynamodb:PutItem",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:UpdateItem"
     ]

    # resources = ["${aws_dynamodb_table.basic-dynamodb-table.arn}/*",]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "policy-dynamodb" {
  name        = "policy-dynamodb"
  description = "A test policy"
  policy      = data.aws_iam_policy_document.lambda-dynamodb.json
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.policy-dynamodb.arn
}


resource "aws_iam_role_policy" "revoke_keys_role_policy" {
  name = "allow-s3"
  role = aws_iam_role.iam_for_lambda.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*",
        "ses:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}





# #IAM dynamodb Rolle wird erstellt 
# resource "aws_iam_role" "dynamodb_access_role" {
#   name = "dynamodb-access-role"
  
#   assume_role_policy = <<-EOF
#   {
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Effect": "Allow",
#         "Principal": {
#           "Service": "lambda.amazonaws.com"
#         },
#         "Action": "sts:AssumeRole"
#       }
#     ]
#   }
#   EOF
# }

# resource "aws_iam_role_policy" "dynamodb_access_policy" {
#   name = "dynamodb-access-policy"
#   role = aws_iam_role.dynamodb_access_role.id

#   policy = <<-EOF
#   {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "dynamodb:BatchGetItem",
#                 "dynamodb:BatchWriteItem",
#                 "dynamodb:ConditionCheckItem",
#                 "dynamodb:CreateTable",
#                 "dynamodb:DeleteItem",
#                 "dynamodb:DescribeTable",
#                 "dynamodb:GetItem",
#                 "dynamodb:ListTables",
#                 "dynamodb:PutItem",
#                 "dynamodb:Query",
#                 "dynamodb:Scan",
#                 "dynamodb:UpdateItem"
#             ],
#             "Resource": "arn:aws:dynamodb:eu-central-1:*:table/*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "dynamodb:DescribeTimeToLive",
#                 "dynamodb:UpdateTimeToLive"
#             ],
#             "Resource": "arn:aws:dynamodb:eu-central-1:*:table/*"
#         }
#     ]
#   }
#   EOF
# }