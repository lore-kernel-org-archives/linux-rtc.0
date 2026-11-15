Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794760141;
	b=YyUPPuYJ+0cDbkbwx9YzwdzRM7oCny9V1B4wQZ/jRPub92TozLodamJyBEsbuPjS4ULs
	 nSc2nhT3N6XGvXvS5ncc1Nq36KOiKZyYx9j0xnLPI+ujOjzJlI7j6snokGl1r+lErHTge
	 gjoUlaOJIthE1WXlUrw/As5BGeoVZSpCmtnLrPdGOC6Rf8m4/Gd+PJuAtb8HPGVQNtqOQ
	 7NylN8IjTVEzdOAcchr9AfwHIAhtuiCWzyxG6h0z9SrilAjfE76SF5S5JXXOu7SmqdKmH
	 MjEwrp1AoOCNY25TWlJ8lm2sANvHLlHAcw1OzZxa1Kr74JKdCQ9muSazSqcty+qJleg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794760141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=TMRcIs/5v6+65U7WavbNtglnS++8zAm5WMPxqy+BIL0=;
	b=MtXB3NdqtdXHy05I1ubZBUmrtqVtGiUNLVEMSCIn6S1gFn6FVRp1SIxlwJ3hke/+e/4b
	 M2wXxUDR7VWpXFdJGRmvPcQDMIMqlgLBDd4bIHL5OOme9yg+SGxmAXnQQb7ygwSXlpu94
	 lxWJzr2nbdabCOKGAxo0LF6o7olmR6rrNBlf2f8lQhG/oe62rxO0klFAYEnutL5xyUBqq
	 QsvdiOJhaA9L45mXjhPljYKCFuXoiXcI4NkdjSazMlSp1Y8R2TLOwFsJmYUwDlFpDN/gQ
	 gZSZX40/ZROnlObSFscIDkCC+wYAqGdGZUyhsLXL+Yq7D86lHUvxwgSriRBeuBQLTgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PKyR/Jgp";
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10408606A329
	for <linux-rtc@vger.kernel.org>; Sun, 15 Nov 2026 16:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10408606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PKyR/Jgp
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53644ab1f7bso29448781cf.3
        for <linux-rtc@vger.kernel.org>; Sun, 15 Nov 2026 08:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794760140; x=1795364940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TMRcIs/5v6+65U7WavbNtglnS++8zAm5WMPxqy+BIL0=;
        b=PKyR/JgpCFUsrRYfOvT1HmcEnpLqZNC25bM+Eca/7XzvIQhoal5gMMnmRwObbm8FzI
         oZwq8azPUC/ciGa8IxvEralb+SasdvBpqP78+DKexH7Nwwo8ZsdvP+sOImiuOx5nOq3M
         n2fuQM62hJWN6nAvHDp/EbKuts4HZIahg7ZtTgdjXWXNRRW0gRtGQ1bzX3C5v2EHDG+I
         S/veLDjns7AplNd4VRMhH69KdVLAvcVqFSBPwYN2qc0s8KncXPVWzNWVpebl7gt6C5IZ
         bmiK/Ih3uBEwI7qkSTB5Zd+/gNvPlhGOMcdHvZ8+ZBvVdq0p9x5ppnsWEv65YEvuIV88
         VTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794760140; x=1795364940;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TMRcIs/5v6+65U7WavbNtglnS++8zAm5WMPxqy+BIL0=;
        b=1znavz+vbQdev9Png9/dmNaaqKs8kpKiKUMm1qUG23taxX0lwNCaq+bbOrWGq/EYMR
         QxM7jDu/kPQqQ5vlsl7ws0UZZhvuwp7QrJu5T5q7V7nxFvB7WCppqVMS+GLT4Gf4BdHc
         yCe5oxT+vHgsZL8jIvBxuIaUSB9sDhXl6owo1R7IreBJP+8+dgI403FjA6ZfUgvCRk5m
         igl2IJP/ZpmYs2nuobANwQZqTVNHpWxCl4/SADfIi/NfRQzK5uHbpkCrpI/fOwFSjptv
         AVRZwjg1hQebz2x2Wq41PGOuB6RT0q/0LaMrqCI/puWhYqOj2upj8u8L2dZyWr+QCHcC
         j5sQ==
X-Forwarded-Encrypted: i=1; AL+hErGMrb91U0iQFjnnaLBCXu6vtxiBEol3GwSFPwGYBd3tL9PYNJMkXY5tT1EvTi0LBbWDve68NEh+UKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kyoO4tNPGCp6Vk4CGYSpKt/EotHYQBnJ/hLC3wWKx+JVJr/n6
	2DespB0vJ7hngzD+cICXtGYp30mkLVYvSSDx+2jJASTNA3TMIcX/OVMq
X-Gm-Gg: AYBFou0pQi6k3ZmC2oZtcuNdxGywqWQ6ZZ00RTwjHlWbaLH8DbwBbRV/7LbW+Q2jExA
	1Uij2Tp3HF0Ljk5uy0/tEXMsQAcv4GS9tMDdJwSQJnLkUdjdazyNDdt+JG8uuJCr9KI5jBdJb5r
	nQ4zdxy9tCZNhdNpuKvvEZHnRpPAAhXWDQbAIpqYLih1hYHl46ZMBnH92JGiI2Iu0Q5thrGOJYq
	IGK34q+RAqoEZFspKMxXuCnkr0rYZZ1p2DIwCcFO10PWMkzDMsMdV0joaMxwCwz202EAzH8+3LF
	Hv86Ro5eCcg+AkxMZYb4sGP8N6iW7o0ezLnFXJGaqY+Lt6NR97ISRQ4wWX+d9bhRHrpMGixRSuX
	H0crpU5i+B4PlHGms14ttpnfEuYPB+T3Ge9PahhUkk10zmza4MgYdiw5sGf83ez3BT6HOoUO0tK
	6myHxgmaEBqPltOa+RYTvM6Oig8mOS6s3g+kCQ0IAGDwfHcCPhGMp2cwqwu7LF/5ZhsJmLPhy79
	J5gOO0U0eiEt97HBodqbP4UZhypAt6xH22n/pxvTd9HGFwag9NmL/rTVvQSNaSKcBdQwDxjKTB7
	57VyYtfF4AQR+3WSDmzOuSLEzRtj6ff86sLQrPyYnuBzM/6mD2iNCcL5rTIMlQyd1dkflDmcynr
	ajbAJk2alG5l8USDvDXP64+QEPGYYfl6eCGSJHw1MsVJ4ekGAOFSf
X-Received: by 2002:ac8:5ac2:0:b0:535:1fe4:64df with SMTP id d75a77b69052e-55ac667df71mr138520351cf.12.1794760139843;
        Sun, 15 Nov 2026 08:28:59 -0800 (PST)
Received: from ?IPV6:2600:4040:5abf:f200::9dd? ([2600:4040:5abf:f200::9dd])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad15eb7basm63744721cf.26.2026.11.15.08.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 08:28:59 -0800 (PST)
Message-ID: <b92385e0-d39a-430c-925e-93dd978769dd@gmail.com>
Date: Sun, 15 Nov 2026 11:28:58 -0500
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sc8180x: Add Microsoft Surface Pro
 X
To: Val Packett <val@packett.cool>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede
 <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20261104070441.74127-1-val@packett.cool>
 <20261104070441.74127-3-val@packett.cool>
 <64e7afd3-50e5-4134-9bf6-92c4aa740bd7@gmail.com>
 <4a7e0f27-60b6-46ec-956b-8897812622a2@packett.cool>
Content-Language: en-US
From: Haipeng Lin <jimmie.lin@gmail.com>
In-Reply-To: <4a7e0f27-60b6-46ec-956b-8897812622a2@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/26 3:20 AM, Val Packett wrote:

[...]>> Would it make sense to move opp-3072000000 and opp-3148800000 into the
>> shared sc8180x-microsoft-surface-pro-x.dtsi? qcom-cpufreq-hw disables
>> all DT OPPs first and only re-enables freqs present in the hardware LUT
>> so this would work for SQ1 and caspar.dtb will cover both the SQ1 and
>> SQ2 Wi-Fi models out of the box and carina.dts won't need its own
>> &cpu4_opp_table override.
> 
> I'm pretty sure mine *did* complain very loudly about having these OPPs and might've even had broken scaling.
> 
> I'll retest again, if it works I'll move it to the shared dtsi (or even the SoC's?)

I like the idea of moving it to the SoC. Did a test on my SQ2 Wi-Fi
with opp-3072000000/opp-3148800000 moved into sc8180x.dtsi, dropping
it from carina.dts, plus a dummy opp-32256000000 above my LUT's top
entry so I can "simulate" the SQ1 situation where there's a DT OPP that
the LUT does not have. Booting that with caspar.dtb:

- no cpufreq/OPP messages at all (e.g., "Voltage update failed" or
  "failed to update OPP" as observed for caspar.dts in this v1 on SQ2)
- policy4 scaling_available_frequencies tops out at 3148800, the dummy
  3225600 is disabled silently (by qcom_cpufreq_hw_read_lut() ?)
- under load time_in_state shows gold cluster sits at 3148800

Hopefully, this solution should work for both SQ1 and SQ2. sc8180x.dtsi
looks like it tops out at 2995200, and that is SQ1's bin above the
"regular" 8cx Gen 1's 2.84 GHz on the gold cluster so if it was broken
it would already be broken for the 8cx G1 due to the SQ1 entries...

[...]> 
> BTW, please send me the output of `sudo fwupdtool hwids`, these are needed to add support to dtbloader/systemd-stub/stubble DT auto-selection.
> 
> (If anyone with the cellular variants reads this: you too :))
> 
> 
> Thanks,
> 
> ~val

This is not the latest BIOS which is 11.504.140 according to
https://support.microsoft.com/en-us/surface/updates/surface-pro-x-update-history
but I don't have dual boot to update it...

Surface Pro X SQ2 Wi-Fi only:

Computer Information
--------------------
BiosVendor: Microsoft Corporation
BiosVersion: 11.311.140
BiosMajorRelease: 255
BiosMinorRelease: 255
BiosReleaseDate: 2/03/2026
FirmwareMajorRelease: ff
FirmwareMinorRelease: ff
Manufacturer: Microsoft Corporation
Family: Surface
ProductName: Surface Pro X
ProductSku: Surface_Pro_X_2010
EnclosureKind: 9
BaseboardManufacturer: Microsoft Corporation
BaseboardProduct: Surface Pro X
Hardware IDs
------------
{bf87a823-6823-50f1-9f18-2030fd86b087}   <- Manufacturer + Family + ProductName + ProductSku + BiosVendor + BiosVersion + BiosMajorRelease + BiosMinorRelease
{43cb3df2-05e6-5637-a89c-718381284f3d}   <- Manufacturer + Family + ProductName + BiosVendor + BiosVersion + BiosMajorRelease + BiosMinorRelease
{1d2505b3-3329-5a15-b934-e1990787e978}   <- Manufacturer + ProductName + BiosVendor + BiosVersion + BiosMajorRelease + BiosMinorRelease
{75b4817e-50ec-5e63-a904-1175cd1abff6}   <- Manufacturer + Family + ProductName + ProductSku + BaseboardManufacturer + BaseboardProduct
{cdf510a8-d41c-54bf-b2c5-61ba10957019}   <- Manufacturer + Family + ProductName + ProductSku
{cc2bc434-a08a-59c0-85ac-2576ed611de6}   <- Manufacturer + Family + ProductName
{69c2fd0d-8593-575f-b6af-5f70f0299ea4}   <- Manufacturer + ProductSku + BaseboardManufacturer + BaseboardProduct
{aa2c30e9-117c-5aeb-a8aa-4b01761cf493}   <- Manufacturer + ProductSku
{b07028e2-19c1-577d-a3c9-2eabef35c2a1}   <- Manufacturer + ProductName + BaseboardManufacturer + BaseboardProduct
{5d018db8-6de6-55f8-8d8b-4b773caf8450}   <- Manufacturer + ProductName
{db7e6e61-56bf-531d-b594-e4b1660d04aa}   <- Manufacturer + Family + BaseboardManufacturer + BaseboardProduct
{ca2e5189-1d32-509f-88a0-d4ebcc721899}   <- Manufacturer + Family
{aca387a9-183e-5da9-8f9d-f460c3f50f54}   <- Manufacturer + EnclosureKind
{f199ec04-d0d9-542b-b035-209532a4d1f6}   <- Manufacturer + BaseboardManufacturer + BaseboardProduct
{cc0aea32-ad2c-5013-8bed-cede6be8c9f4}   <- Manufacturer

Thanks,
Haipeng

