Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8929612CDBE;
	Fri,  7 Aug 2026 00:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786060969; cv=none; b=KymaFfUygFcnVYMzZA5XB236EHNXFTfcDa+2O21OV7/2IpEGesFEqeOvBvQZxi77uUXG2ePMzg+0UWxDqGULSULrxzxV55MOOzspLlxfCzLmDcokpPeWi/w2Kanuf6CiHvWrNCREv6Bj/sl7WHEWGHOeSh2chS055gtSx36H+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786060969; c=relaxed/simple;
	bh=4OW3l9cKGyzkV4CKtQgbnUWsn5DHoMfqWO7DxW5YLpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar46EjVIvLzwrW1yviWPhbUkMUVrfQgo/HYOiEWgJSQnHD6KiK2HrLbkVv5HbBH/k+lXxFFNH9z+TJtCpnZa7Velt8CFyhr9wqB0AU1wCnhFhL3YUptvMKzvW2XqoqKGBD0uP5zmC6DyJSqRQTGd9Jjq6I1eBKrfN+z/w4D0Je4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH3vzZxW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH3vzZxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CE01F000E9;
	Fri,  7 Aug 2026 00:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786060968;
	bh=z+uE9oKn/qWIRG+x5jQxIvcpzfB0TrhegkqzxFdZEm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mH3vzZxWp94MwY64bgsC/+29BPEypmxcJqV8wmo39s4JAIQeuTF0pLM34joI30bxx
	 H3z2nFh9ldaK6XEb2Irzg+gQec+wVav+k7PS1bGta4d6TboYKH4sde3x2X+2qkOuAZ
	 jy87fN8gZ+pfcmBzdOa5jzwd/akl9qipuMxwkUL+UbRATcs435CjqCTdfHjINWPSrO
	 lItzS3Ong9fU9zL8JJm4nSxx5gLRufMZ28uk8+cXJTrUGhNJJLHunObD3DA/qu9UO/
	 0H/hSnIn711QVd4MYASK6QBYqoXXSwny51ctfO4DUObR2vDm+8p1rWQPUKRuAmmKTl
	 +YPggvXfN74sA==
Date: Thu, 6 Aug 2026 19:02:44 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Raj Aryan <raryan@qti.qualcomm.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: qcom,pmic-glink: Document
 RTC client properties
Message-ID: <anUemwQJgHJP7iOS@baldur>
References: <20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com>
 <20260807-rtc-glink-cleanup-v1-1-7801e4d69c4f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-rtc-glink-cleanup-v1-1-7801e4d69c4f@oss.qualcomm.com>

On Fri, Aug 07, 2026 at 02:26:30AM +0530, Kamal Wadhwa wrote:
> The pmic_glink driver can now register an RTC auxiliary device on
> glymur, whose PMIC exposes an RTC over GLINK (see rtc-glink driver).
> Document the allow-set-time flag it consumes from the parent
> pmic-glink node.

The driver functionality has no relevance to the DeviceTree binding.

The binding defines the contract between the DeviceTree (DTB) and the
implementation, such that the implementation knows what to expect from
and how to interpret the DTB.

> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Raj Aryan <raryan@qti.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

As with the driver, the author/s-o-b chain is wrong.

> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> index 16ad4f5698fc..38db1ff473c0 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> @@ -79,6 +79,11 @@ properties:
>        - const: charge_limit_end
>        - const: charge_limit_delta
>  
> +  allow-set-time:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Indicates that the setting of RTC time is allowed by the host CPU.

What property of the hardware/firmware that this describes would cause
you to set or not set this?

Also, what would the expected outcome be if I declare that my Hamoa
hardware has pmic-glink with allow-set-time?

Regards,
Bjorn

> +
>  patternProperties:
>    '^connector@\d$':
>      $ref: /schemas/connector/usb-connector.yaml#
> 
> -- 
> 2.43.0
> 
