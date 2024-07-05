# IAM Rolle wird erstellt
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# basich policy für Lambda beim erstennen der Role
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

###################################################################

# Zugriffsberechtigungen für Dynamo DB

#Die Policy / Berechtigung erstellen
resource "aws_iam_policy" "policy-dynamodb" {
  name        = "policy-dynamodb"
  description = "A test policy"
  policy      = data.aws_iam_policy_document.lambda-dynamodb.json
}

# Inhalt der Policy
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

# Role mit Policy verbinden
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.policy-dynamodb.arn
}

#######################################################################
