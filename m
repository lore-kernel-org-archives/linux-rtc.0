Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794730839;
	b=k+0UHPllgES+4v5Hi3qouXmgqsvEQI/1wQagtNRFv1S9/V/G0WaHElIjSU5jsNYP17kg
	 f4dz6e6Ej5PTJGKcjLK0RCTYA0Wy02e3224O2xTVaiOqyDCEe7Wq0M2cyh8PAdLTz3lUh
	 p/y+AyVHOX94gCZD13mMWLw51wKgqVuTnfpVa05sSkoXR8zD/tBNetmA4hvht8NhdnpW5
	 wEaJBOKM0vt6n+0Tdynsspi5rQlFihaPDUdhplUads4hTfsNIiT68ulJbQtjq8NJROwf3
	 0lf7YaYNMc9NzgJfg+zGlOtlfp22XazcJABREMIFR8sImExsZrXE8gYG9SioqZ6123g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794730839;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=AJ1xfee2Csn9VN4fhbIm0y3xwJVteInbog5JyVAqWMQ=;
	b=iZQynYo3ZpAMxJkuM5zG9jLLVDNTzylb/Z/D8Pewe5wLM2VvQeJO8gGfw8QJzeTX3gNm
	 tZ4ZJkkLQbXZegies1nQmzO9ezJ3Csdme6vmaBCVoo314V0aQcGt2y7s+oykIGUnRQU2O
	 3t9MlGfjCg2bcx2u+jHt9x70KeX9TpKgqJSMoDRb6fTfonlTq0GLWiet0bx4tU/RehA5F
	 0hwDJqxDyop/DiVjlyPChGggOY+pVl9ffTq+eyUZ9j56LQfw3fnJ75PaOkdOVfB1dLD4+
	 9pa/F4/zvLuN0r737/e5aISweBozTVXMQVnsHbAwqZ4M4uLwqjN5enMDQubwCut7UQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=P8JwMvKM;
	arc=none smtp.remote-ip=95.215.58.60
Received: from mta1.migadu.com (out-60.mta1.migadu.com [95.215.58.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DC5606A31E
	for <linux-rtc@vger.kernel.org>; Sun, 15 Nov 2026 08:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1DC5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=P8JwMvKM
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6Q2a8Doi+A+WH2MhvcE6/e3oliRLG1FAhetxf+CGFl0=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794730835; v=1; x=1795335635;
 b=P8JwMvKM7F/skTX9h6XCjQAdOAidih/jfip94v06HSKWXrzk3uFWRJiB/BJWhdCk2pGxc03Y
 z8dgHjcorsAzSXLC07n4nwZutGuN1EbUxxDQKbz3nf+IHeAv+1MWB7KcwjY/ia+kBewD08sOhAY
 LlxST8kjAQdgeeo8ibKA/ngJjqnBrlwdkgUx3XxrUv9gqZlzvvKQ4Ce8Pa/sXvpo2rN5Sqpj8/u
 y0NLokh+t8x9BQIVYdWIR0dVkZQAVzIjcYaI9JnueSS2yFKd6zB+MteEyqry9HuNPVgNPWsD03r
 vuTd7VUS6mzOaiuzsTvyJx3yk0dKkc1BbfNQi6yEOu6jw==
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9046fc18112be64a;
	Sun, 15 Nov 2026 08:20:19 +0000
X-Mizu-Trace-ID: 9046fc18112be64a
X-Migadu-Flow: FLOW_OUT
Message-ID: <4a7e0f27-60b6-46ec-956b-8897812622a2@packett.cool>
Date: Sun, 15 Nov 2026 05:20:11 -0300
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
To: Haipeng Lin <jimmie.lin@gmail.com>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede
 <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20261104070441.74127-1-val@packett.cool>
 <20261104070441.74127-3-val@packett.cool>
 <64e7afd3-50e5-4134-9bf6-92c4aa740bd7@gmail.com>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <64e7afd3-50e5-4134-9bf6-92c4aa740bd7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/15/26 12:16 AM, Haipeng Lin wrote:
> On 11/4/26 2:04 AM, Val Packett wrote:
>> From: Maximilian Luz <luzmaximilian@gmail.com>
>>
>> Introduce a device tree for the Surface Pro X tablet in all 3 variants
>> (SQ1 with cellular, SQ1 Wi-Fi only, SQ2 with cellular).
> [...]
>
> I believe there is also a Wi-Fi only SQ2 variant. Looking at the WoA
> drivers for 8180_CAS (Caspar, Wi-Fi only)
> https://github.com/WOA-Project/Qualcomm-Reference-Drivers/tree/master/Surface/8180_CAS/200.0.31.0
Huuuh, okay..
> This variant is the only that has both SurfaceSMF_SQ1.cab and
> SurfaceSMF_SQ2.cab. Only 8180_CAS MPSS INF maps the no-modem subsystem
> ID (SUBSYS_MSNM8180 -> qcmpss8180_nm.mbn), the 8180_CAR (Carina) only
> lists the cellular MSWW/MSJP/MSCN IDs.
>
> My SQ2 Wi-Fi boots with the caspar dts in this patch fine but the
> gold cluster is pinned at SQ1's top clocks because the 3.072 / 3.1488
> GHz OPPs are only in carina.dts.
>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-microsoft-carina.dts b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-carina.dts
>> new file mode 100644
>> index 000000000000..5d155c69907a
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-carina.dts
>> @@ -0,0 +1,50 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +
>> +/dts-v1/;
>> +
>> +#include "sc8180x-microsoft-surface-pro-x.dtsi"
>> +
>> +/ {
>> +	model = "Microsoft Surface Pro X (SQ2)";
>> +	compatible = "microsoft,carina", "qcom,sc8180x";
>> +};
>> +
>> +&cpu4_opp_table {
>> +	opp-3072000000 {
>> +		opp-hz = /bits/ 64 <3072000000>;
>> +		opp-peak-kBps = <8368000 51609600>;
>> +	};
>> +
>> +	opp-3148800000 {
>> +		opp-hz = /bits/ 64 <3148800000>;
>> +		opp-peak-kBps = <8368000 51609600>;
>> +	};
>> +};
>> +
> [...]
>
> Would it make sense to move opp-3072000000 and opp-3148800000 into the
> shared sc8180x-microsoft-surface-pro-x.dtsi? qcom-cpufreq-hw disables
> all DT OPPs first and only re-enables freqs present in the hardware LUT
> so this would work for SQ1 and caspar.dtb will cover both the SQ1 and
> SQ2 Wi-Fi models out of the box and carina.dts won't need its own
> &cpu4_opp_table override.

I'm pretty sure mine *did* complain very loudly about having these OPPs 
and might've even had broken scaling.

I'll retest again, if it works I'll move it to the shared dtsi (or even 
the SoC's?)

>> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-microsoft-surface-pro-x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-surface-pro-x.dtsi
>> new file mode 100644
>> index 000000000000..17fb01c6b164
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-surface-pro-x.dtsi
> [...]
>> +&smb2351_2 {
>> +	status = "disabled";
>> +};
>> +
>> +&smb2351_a {
>> +	status = "disabled";
>> +};
> Confirmed on hardware that labeling pmic@2 and pmic@a in
> sc8180x-pmics.dtsi fixes the dtc build failure here.
Yeahh, forgot to include, will be in v2
> [...]> +&uart13 {
>> +	pinctrl-0 = <&uart13_state>;
>> +	pinctrl-names = "default";
>> +
>> +	status = "okay";
> [...]
>
> On linux-surface, ad1bb617a15a from Maximilian Luz had
>
> &qupv3_id_2 {
>    status = "okay";
> };
>
> Would it be helpful to add here? I confirmed on hardware that adding it
> allows uart13 (WCN3998 Bluetooth) and uart15 (SAM EC) to populate and
> probe properly.
Of course; it should've been the _2 in the first place but I made a 
mistake during last-minute cleanup and left out the wrong ones…
> Thanks,
> Haipeng


BTW, please send me the output of `sudo fwupdtool hwids`, these are 
needed to add support to dtbloader/systemd-stub/stubble DT auto-selection.

(If anyone with the cellular variants reads this: you too :))


Thanks,

~val

