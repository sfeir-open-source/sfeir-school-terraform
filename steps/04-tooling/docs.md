## Variables

<table>
<tr><th>Name</th><th>Description</th><th>Type</th><th>Default</th> <th>Required</th></tr>
<tr>
<td>allowed_config</td>
<td></td>
<td>

`list`</td>
<td>

```json
[
  {
    "ports": [
      "53"
    ],
    "protocol": "TCP"
  },
  {
    "ports": [
      "53"
    ],
    "protocol": "UDP"
  }
]
```
</td>
<td>no</td>
</tr>
<tr>
<td>gcp_project</td>
<td>GCP project use to deploy resources.</td>
<td>

`string`</td>
<td>

n/a</td>
<td>yes</td>
</tr>
</table>

## Outputs

None

