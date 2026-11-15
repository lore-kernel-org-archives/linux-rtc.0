Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794712587;
	b=eFwmyFnqDJDqxcanmMJk9mS7vMsmx/DT2on5XTmxacXwa817yx19XOYJnAPhgQAX3wqJ
	 96AlEKSKrf+KlzbUDDP/mNT3DO9Q760gEE/poo2mueD+bbZuCP2tLxX+waoKsd4nFDBxj
	 3E6QHOXW9Mtf18aGW+uCIwHX0bJqB06zKrGAT3Pk0YO2f2lAPaxuEHt6ryjwIWoqOmiLs
	 zIQWb1aze4HZb1TDxdhh3kaDD0CqH+HjycCuZpWJ+xhbhHCWGZzwoJWfXjQLNA+xO247p
	 bEWRqXyxPRTdfv5m7ZhKaj12JzgfDN9D35YbPH1Hcp2CMm5AIzMRYc+VOglEnN8k2eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794712587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CcJ012d98pXUSkoe1frivs9auTK2SIP4GqFrJm7lBB0=;
	b=m/CYNGKbvx3l8s+l6L1MKMz4SCLY1oLJ7CZvtmnKt4A+5gjwbkBqSa2+83XYqQx8aHjn
	 TTC2trXShL7tNwrMjmnRrm2NEt6JqPG7nRwf5061NUoV+EkqbSo9uTKhOqIRXkV0nGDn+
	 +9Rqf4+QAHrZnycfuiB0tV1cvI9jkzxKAKEReA97eg3yI4v9d3P0QUspyfTQMtgrQtnXX
	 u2Cv/8Ny2osQHyTi+f5yoCy4IfJ2IoH8lvbC/+22QJup5x4ZheXUEO/7zEO9H/MgvSkTT
	 DTKrGPJkM5XGW1siOe4oLp6Heq7JKjZqdtSh0RCZx7cgB1DBbSbG3r4u6z1DyxI3xyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nDn0QXj2;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B010606A329
	for <linux-rtc@vger.kernel.org>; Sun, 15 Nov 2026 03:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B010606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nDn0QXj2
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-537548b811aso15205831cf.3
        for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 19:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794712586; x=1795317386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcJ012d98pXUSkoe1frivs9auTK2SIP4GqFrJm7lBB0=;
        b=nDn0QXj28VQiPE4K98zv5Xh4Yjwm7t62UjfcLenYcqhOo5h0hOqiS5xRcIA+4og9N2
         RQnaKdJY7YvgPODxmsSwlcrY5e5hmYdGYAcDU3VLp8O2fanyyBW03GWvOAseg3YKVdur
         kJfGd1SrZPthJUpnDRewkGPwhaYIaPPNTbbS56apxaAVCCfxkUMWfqQHbKpJT8YqXfv5
         Mcyw0FRhIlWfUUIL+x+uCTrj/JwnpVeszdWxBl+iAw38yG/4doOmbb0ThJSXidy1DVyR
         TYVJLU/lLzVbaP8O7bmJVWScaD1ks1j524vQgyhJAKOpZjMA3R6pnDA3WPVQyVZEngmE
         gcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794712586; x=1795317386;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CcJ012d98pXUSkoe1frivs9auTK2SIP4GqFrJm7lBB0=;
        b=DyBZES5R8nL2z/PTiPTMm2AWVFpk6wHrXYjXXyPous5RBD0nSvOWzpQWMyx5bry/x5
         6LUAnxN87t5ut60zAqwyB1J4vVn8lGTW0CmBW/GZ+5aNWOuwVQKYS3n9i/uWYoxuQXEe
         HNKmuCugMqMX7senzHNFMWg5MVaEjdtK6h1Tl+UI63WiqLuLGiWuAjbCfnBdeWlZhd5T
         LZ2hVPfIm3cb3sZmqfQ8hmFjJQETws1Grs1dvoQoEGvZOZUHq+BNurgQvQihoTxvSQrJ
         hLjWYRXp+rQYE2W4u/H9c224qzxBl/vkwXIWce9ey2NnTFvwqZWyJhpRT2guIXkSLaLD
         ck5A==
X-Forwarded-Encrypted: i=1; AL+hErH2ppilj16pJek/Q6jT0izFqC6xY9lQfApUiylHZHtRrWqKgpPI1cp2KE7YFa/L8566yAqYzyM0HPI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hEI+0VhE5cp27QwS3ejJQVoSd1Aakq9IyPTgD3ugARRg/U/ss
	W1caWvLbZC5r4bLNezXlLjAT6noKMsfsJEqSMglPgLUMgwhL3Y5y+ghF5gGSiHolAFw=
X-Gm-Gg: AYBFou1YtGu2KHhVjcaqnXeSHns4uBwKO1EO23tnzFTedoDD7cV0OZjHUk/tI+dKrrm
	LsgVI18thXIRiFYRwtuam/nAMJBtxpg3AvGYgEO9sXC58SVqoLoPQ4kj/TP7IdWrMKysAMuI2W2
	3GYvIc13Gv1frnipTq9hZwGJTxFZBuH/VLadqNmDvE7Rns7Gf/P1ZQBBKLcEQkYPJv2jIhnwNXq
	yDJpsAT8CfNOW6ccg1e8ltO+eKLNcpYWHsO4JtbYkBjcTOhGW2Y60Zh6sEKBE25ZYjQcmLESCzv
	Bm0smrzvLb9cfpsiCB54vDYpL2yQYbhDyCqeNjnV4zRQtbz5EaTT7VY2j48ye4YMrW8+gbMiHNp
	Yh75D6TVioMAk+eRqnbONCek2nnTdTKTDM0PMXhIsjjyWUIi9N6o2fNJDURRe1yzPh0pCDQOFKL
	r4mQPXiWvnADQu5KuEcfChWvtETdNq4p1uiP6Jpwe3CqfVEG0VwrTxOQV60nPGiSKi8GwWZ7nWF
	mLpr+Hd/HBB58uWFKpgyD105ErBqSQqkikZga43gCnnlQvwSAUfxBMyQWUoStod5kXFdwMnmK/V
	i3lhkVzgJs8LOf2ygRfcsaNdjXnQcCSvIhxMuAsc9U44RGFDl+PaV5V1NJgX/+CVgTQr1JpCAvj
	VADmEEV05UTW5LjpZ16dEXR9c586DJksArAurwn8AT0xGBgmKJY0kYA==
X-Received: by 2002:a05:622a:451:b0:55d:13c7:c232 with SMTP id d75a77b69052e-55d13c7c737mr38400571cf.51.1794712585934;
        Sat, 14 Nov 2026 19:16:25 -0800 (PST)
Received: from ?IPV6:2600:4040:5abf:f200::9dd? ([2600:4040:5abf:f200::9dd])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad1b13917sm52366751cf.29.2026.11.14.19.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 19:16:24 -0800 (PST)
Message-ID: <64e7afd3-50e5-4134-9bf6-92c4aa740bd7@gmail.com>
Date: Sat, 14 Nov 2026 22:16:23 -0500
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
Content-Language: en-US
From: Haipeng Lin <jimmie.lin@gmail.com>
In-Reply-To: <20261104070441.74127-3-val@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 2:04 AM, Val Packett wrote:
> From: Maximilian Luz <luzmaximilian@gmail.com>
> 
> Introduce a device tree for the Surface Pro X tablet in all 3 variants
> (SQ1 with cellular, SQ1 Wi-Fi only, SQ2 with cellular).
[...]

I believe there is also a Wi-Fi only SQ2 variant. Looking at the WoA
drivers for 8180_CAS (Caspar, Wi-Fi only)
https://github.com/WOA-Project/Qualcomm-Reference-Drivers/tree/master/Surface/8180_CAS/200.0.31.0

This variant is the only that has both SurfaceSMF_SQ1.cab and 
SurfaceSMF_SQ2.cab. Only 8180_CAS MPSS INF maps the no-modem subsystem
ID (SUBSYS_MSNM8180 -> qcmpss8180_nm.mbn), the 8180_CAR (Carina) only
lists the cellular MSWW/MSJP/MSCN IDs.

My SQ2 Wi-Fi boots with the caspar dts in this patch fine but the
gold cluster is pinned at SQ1's top clocks because the 3.072 / 3.1488
GHz OPPs are only in carina.dts.

> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-microsoft-carina.dts b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-carina.dts
> new file mode 100644
> index 000000000000..5d155c69907a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-carina.dts
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +
> +/dts-v1/;
> +
> +#include "sc8180x-microsoft-surface-pro-x.dtsi"
> +
> +/ {
> +	model = "Microsoft Surface Pro X (SQ2)";
> +	compatible = "microsoft,carina", "qcom,sc8180x";
> +};
> +
> +&cpu4_opp_table {
> +	opp-3072000000 {
> +		opp-hz = /bits/ 64 <3072000000>;
> +		opp-peak-kBps = <8368000 51609600>;
> +	};
> +
> +	opp-3148800000 {
> +		opp-hz = /bits/ 64 <3148800000>;
> +		opp-peak-kBps = <8368000 51609600>;
> +	};
> +};
> +
[...]

Would it make sense to move opp-3072000000 and opp-3148800000 into the
shared sc8180x-microsoft-surface-pro-x.dtsi? qcom-cpufreq-hw disables
all DT OPPs first and only re-enables freqs present in the hardware LUT
so this would work for SQ1 and caspar.dtb will cover both the SQ1 and
SQ2 Wi-Fi models out of the box and carina.dts won't need its own
&cpu4_opp_table override.
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-microsoft-surface-pro-x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-surface-pro-x.dtsi
> new file mode 100644
> index 000000000000..17fb01c6b164
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-surface-pro-x.dtsi
[...]
> +&smb2351_2 {
> +	status = "disabled";
> +};
> +
> +&smb2351_a {
> +	status = "disabled";
> +};

Confirmed on hardware that labeling pmic@2 and pmic@a in
sc8180x-pmics.dtsi fixes the dtc build failure here.

[...]> +&uart13 {
> +	pinctrl-0 = <&uart13_state>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
[...]

On linux-surface, ad1bb617a15a from Maximilian Luz had

&qupv3_id_2 {
  status = "okay";
};

Would it be helpful to add here? I confirmed on hardware that adding it
allows uart13 (WCN3998 Bluetooth) and uart15 (SAM EC) to populate and
probe properly.

Thanks,
Haipeng

