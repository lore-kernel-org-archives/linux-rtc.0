Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794713108;
	b=jWA2wBJL3UnIyMF6Kq67lN+Gb36UIoaJ7IbqIEhuxm47Qnb16SrUewx6oQ/fXPGY8iAC
	 /gB1uETeZDxvQmRzCo1kipHR1mgJHGw+ENo0SdvnbDfUOIeUsKr6l17EnSkvjlM/4/0I+
	 WGoMtVRSzmUtncajz5PtoBwppDxFWzABnXlM+XzMwq22GwX/L8ec4gI9BQS0OLGwKNEEK
	 hzG6rXK0aRnhCyLJdkHkb2yjh6fsFdOvaSwmnAmenqa8nPPYUSsttrjqVnbY6HryEMipE
	 /xT8PdOmn9ZeATHVOw+ZxRs21Q/j5JSBFdyyPFdwWlaiUwKByot/xRlhAi61rGW1pOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794713108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+jVTqA8bBEUloDFP/osFHIzevEsOMQXn438BieV9inY=;
	b=j8ixRO3GZm8VfXaz1Z0YgGuAdcG4QfeKSAyQpqByArtKrlQ1Q2oQr+6zpbLG2zSuG65E
	 plSFS8LTH5CSgerTLNLk2w0DtbawrlEzftM3z3pp/9iIpHnl8vJiyTA56OBC8eBpi4FmA
	 pF5bvAOx/7gD7j+1bgSjMA9NPVgEe1etawH0nIo+DaFe7pH94X2pMDc/CFiCLBi1WaA/D
	 np+Ow4ucBkWjhRwq2xu6DYKl6hfOg9RP0ENCzIuaZMMzO6jhJTV81FqZ3oNjBr2tkrJQn
	 pB3FAfgb26t88T6COO6TYa+7TBLcdGY8isz/ArIwMLH9p18LK3EocZ+FDirXtwaaFWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MhbsYhlf;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B5606A32C
	for <linux-rtc@vger.kernel.org>; Sun, 15 Nov 2026 03:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD8B5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MhbsYhlf
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-55d2d380f6aso4621881cf.2
        for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 19:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794713106; x=1795317906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+jVTqA8bBEUloDFP/osFHIzevEsOMQXn438BieV9inY=;
        b=MhbsYhlfIboDlJO0nr8sWHoWk4QYWrxgr1DjannNHaSkkSgGBBcYSs3djiqkqFC1/6
         m0ZUne9cIuREQdr+58Uva+zsdg7kB5jgVKFXT6YY5hMIQlk7C9QTgBmy54+Hsr1PeRq2
         2XOw+re1SXRO4deRkyfpCKCg9/tFNYIwb1FHKXZIa8tBcGgxkRV+CABQxMzK11Ij9vXa
         SJMpOs4QIBCCiBaHDKjfNDYhy9HIsKamrxfvjAbVPx35B15vgPxKu6Gx0VOqpzzktnT5
         3CYJZ8VOssDKKYsXLUo5CP3y6tt+shDW+HAXFmMdCBoh8/v5nTcNrF2sm8DK9wyREbNj
         MrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794713106; x=1795317906;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+jVTqA8bBEUloDFP/osFHIzevEsOMQXn438BieV9inY=;
        b=iqS4zLwZma3eDlhSBsayxfBHLSQS+RClZhgnGyhF1+PP7N0MniPAg+8cai8NNfVHow
         shj4w/YBv+dPHAVbWUYfMD+L0QeecIxtJVisaSPjbYxlgCSot94ck03pEjNMfDmCmDrU
         ahcdeTdwthOzjPKmquOHZKISmKB/46wX4WcRUPLbIPFJVGxE+3+vIINxHVZ8kwN8mnBs
         Fsx6PAivG56iWqFlfiD93mDg7yfcTDMayCztMF7SIRYvh2RtN/RwvmSWCFSoaaFfALsZ
         q5IAW7PVIx3FFbH5YgnPnpUTlWl2GRdqD+imDmd+b6Mjkp7bW15QIzmfigrqPwnHAs8J
         KTqg==
X-Forwarded-Encrypted: i=1; AL+hErFbkMtOZLpn8xk/yS5OPtccaZf3mXPKLpASPB3XTri6AIlkI5UR2GPUUj3DYg1aSuBS4nQtVYgSgCc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BjA/2euLTr7VJg7l1cIrqkZW1wcqW+pPqgDk3kwGaszMT++cN
	7W1W+DDYLAEUyUCnUJHJsXBRrG2y5cmi2ed6LGJ/bjplkoLCtIG32OV1
X-Gm-Gg: AYBFou2njkY8hLFNmXaKGE8hL5KpKKInckbfApfYYUNJwrF/qDd+yHCT5ltstE/vgZ/
	M1fwnRidjSPvwSOpOg2kiKmSa8W6hzpCciLTMz2s3aRLRViPtXEgZRwiiBOioEnAYvzk/zfYNj2
	M6GBLOP2Yhk4Ryh9Z91Ps92Y9f38IY7BNWMfooucVH2pZ0bKNWhtJO+DivaqJGRmXsdN7B/7nIP
	eIhtEVA2NyV8X4pACtTp1/8yCZy7HIGQz8XZuoehYJpd6P/j5EnAdRsGCIYMxx4K2lhvE7huUar
	wZKrHs3Ih8X5LUCwnhbNeU+yDmWZkCphp8/e1sSL0JRzDyQvTFPY1OxkpA5O448xiOLAXmwBO3N
	UK2eRJWroHqbRCyKGFk0+R9SrqzGiUChgjy01dV0JD3GTTA8AGgfI1ET1eIKS+dvdE6KbN8kLob
	A6k+XdJ00xrlNvWCov0a2ZvoNYNiFjajnJCVZU9mSGrpVxm1PyA+HpITetGsd37q4qCYfLIgheH
	wP3W8YO/2pET/uoAEZpLO3yHP5BJu5/IPbRtCuIgP3MjVbHNHFkvXrGK3H5bRWiWBn7Ap4TbdyW
	m9Rp//jsWI8L29uBU+Kv1ZeQRZdbLh0CGLOZIKcp0DFHM8DGWSd0WU/cJOLm/QvH0hJAHMpu32I
	Tb8MUr2HLrejZnqsH21jJcIntWs8KTNi3ABwxnPJW58VpPiahLoK/
X-Received: by 2002:a05:622a:228a:b0:54a:6b3:488d with SMTP id d75a77b69052e-55ac7172abamr111430891cf.21.1794713106562;
        Sat, 14 Nov 2026 19:25:06 -0800 (PST)
Received: from ?IPV6:2600:4040:5abf:f200::9dd? ([2600:4040:5abf:f200::9dd])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d6193esm55747396d6.19.2026.11.14.19.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 19:25:06 -0800 (PST)
Message-ID: <81ac592f-18a2-4715-a34a-1f639ff7a454@gmail.com>
Date: Sat, 14 Nov 2026 22:25:04 -0500
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
Subject: Re: [PATCH 1/5] dt-bindings: arm: qcom: Document Microsoft Surface
 Pro X
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
 <20261104070441.74127-2-val@packett.cool>
Content-Language: en-US
From: Haipeng Lin <jimmie.lin@gmail.com>
In-Reply-To: <20261104070441.74127-2-val@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 2:04 AM, Val Packett wrote:
> The Surface Pro X tablet was listed as a single generic compatible in
> dt-bindings, but a device tree using it has not landed upstream.
> 
> Replace it with three model-specific compatibles:
> * microsoft,cambria for the orginal SQ1 model (with cellular)
Nit: "orginal" -> "original"

> * microsoft,carina for the Wi-Fi-only (SQ1) model[...]
Nit: ,carina -> ,caspar

Wi-Fi-only has both SQ1 and SQ2, please see reply to 2/2 in series.

Thanks,
Haipeng
