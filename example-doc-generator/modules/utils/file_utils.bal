// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied. See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerina/time;

public const OUTPUT_DIR = "./artifacts/execution-prompt";

# Saves the execution prompt content to a Markdown file in the output directory.
# The filename includes the goal slug and a timestamp.
#
# + content  - the full execution prompt content
# + goalSlug - a short hyphenated slug derived from the goal
# + return   - the absolute file path on success, or an error
public function saveExecutionPrompt(string content, string goalSlug) returns string|error {
    // Ensure output directory exists
    check io:fileWriteString(OUTPUT_DIR + "/.keep", "");

    // Generate filename with short goal + timestamp
    time:Utc now = time:utcNow();
    time:Civil civil = time:utcToCivil(now);
    string timestamp = string `${civil.year}-${civil.month < 10 ? "0" : ""}${civil.month}-${civil.day < 10 ? "0" : ""}${civil.day}_${civil.hour < 10 ? "0" : ""}${civil.hour}-${civil.minute < 10 ? "0" : ""}${civil.minute}-${civil.second < 10d ? "0" : ""}${civil.second.toString()}`;
    string filename = string `${goalSlug}_execution_prompt_${timestamp}.md`;
    string filePath = OUTPUT_DIR + "/" + filename;

    // Write the execution prompt to file
    check io:fileWriteString(filePath, content);
    return filePath;
}
