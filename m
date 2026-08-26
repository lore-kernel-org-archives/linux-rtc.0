Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFBA382381;
	Wed, 26 Aug 2026 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787724705; cv=none; b=lIymfCWkDZ0RSDWU4mNLLMwbs5v2SX0RShIqTqEUPLu4PLsoMI2URoIR8Qqn4GndHOxA66oLLV9JClH4ZnOC8f+PRN41Wr/MIFOHIBCYSVIVkiEWuXr7AYzgdv/G3wmlGD7NFHSHYJXnz09CEyAKwKjb8JfF8Xs0FmNV17gsd70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787724705; c=relaxed/simple;
	bh=p5rd62iu1F1bWmMdDwRWV7uxCjGSGWgxxbjp7cYchOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxMvAX4HCDfD0DMpNq5WsdWATAFT9s22imDqz4EeveFuk0Zk69irAWYIuEdY6KIHei0vc4kJRlcFX5c899rWqlFbA+M6iFNgevAQ/Nx0emfvFwId5FUvvjo+bDgGFkAJm3/ilkzM2rouv/4AEqySpDCUluFC6nSnhRUIeflOOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIJBtjFP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIJBtjFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D221F000E9;
	Wed, 26 Aug 2026 06:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787724704;
	bh=tjgj899LB73BsE64ASVcbSLypzAb4RxBabj74yJwzRQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DIJBtjFP4LwFe2pokmGh3Z9wGYH8W9DAOw9gnuj0Z0MwxZ0U8FiHixBrPjx/+xfd5
	 oeQzzIt5hyJFB2LYrpbuCihd7O3TdqWTl89LExZs9kLaqynSSaikFImcJ7sWQxnvts
	 tejHBO6SrKPo9wHSrurO0hFNlptGLD6GDF71eGFqkcflCOoRbj+i5vHUG3jdsnE5Ou
	 +/ZYY1kkIqagOBMl4SeqBwV5el0Ryk0xkSuAt8NMO4Q6J2n6Q2PrYdOCHAlJ9xTPvy
	 zUA17ykD/SukhlbM0u8o4FoA20escKoPEViV+XKdo3d3mYCFsWTxg7oaRWcvXOHs5u
	 64HPpRkOWa6OQ==
Message-ID: <6079c72b-cb98-4a38-b887-962a78be2877@kernel.org>
Date: Wed, 26 Aug 2026 08:11:36 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: qcom,pmic-glink: Document RTC
 client properties
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, Raj Aryan <raryan@qti.qualcomm.com>
References: <20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com>
 <20260807-rtc-glink-cleanup-v1-1-7801e4d69c4f@oss.qualcomm.com>
 <anUemwQJgHJP7iOS@baldur>
 <2yndadk6urzktzbb4mg7rhnywb3lxi6liuw2afdee6tswhnl6h@tqvt3n2r4qkj>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <2yndadk6urzktzbb4mg7rhnywb3lxi6liuw2afdee6tswhnl6h@tqvt3n2r4qkj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/08/2026 21:23, Kamal Wadhwa wrote:
> On Thu, Aug 06, 2026 at 07:02:44PM -0500, Bjorn Andersson wrote:
>>
>>>
>>> Assisted-by: Claude:claude-sonnet-5
>>> Signed-off-by: Raj Aryan <raryan@qti.qualcomm.com>
>>> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>>
>> As with the driver, the author/s-o-b chain is wrong.
>>
> 
> Ack. will have it this way
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Signed-off-by: Raj Aryan <raryan@qti.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

The original SoB chain was right in such case. You sign only once, so
first one is dropped. And this is what b4 produces.


> 
>>> ---
>>>  Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>>> index 16ad4f5698fc..38db1ff473c0 100644
>>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>>> @@ -79,6 +79,11 @@ properties:
>>>        - const: charge_limit_end
>>>        - const: charge_limit_delta
>>>  
>>> +  allow-set-time:
>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>> +    description:
>>> +      Indicates that the setting of RTC time is allowed by the host CPU.
>>
>> What property of the hardware/firmware that this describes would cause
>> you to set or not set this?
>>
>> Also, what would the expected outcome be if I declare that my Hamoa
>> hardware has pmic-glink with allow-set-time?
> 
> Actually Hamoa firmware does not support it yet, so it may get ignored.
> but if the support was present, the writes will cause the system time
> to go bad, which relies on the RTC time elapsed during off state to 
> calculate current system time, incase network is not available.
> 
> this was used on rtc-pm8xxx.c driver as well
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/rtc/rtc-pm8xxx.c?h=v7.2#n622


It's a generic property, so where is it defined?
Why isn't it implied by the compatible?


Best regards,
Krzysztof
