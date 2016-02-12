#!/usr/bin/env bash

aws iam put-user-policy --user-name chekout-cauri-instance --policy-name CreateSnapshotPolicy --policy-document file://MyPolicyFile.json
