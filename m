Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794711196;
	b=x0DqxflBGGIlxiYTItYJXUurt1XBCa31icdkyDQzL62sM66X4vpXBJdeX3KZDY8UaJvw
	 0o38vuVGsywPMxa93o6J4C3r8dk8+Qt00dSw9p9Oe1OBcqj6CnSLrLtPembKwmQ9WqyL3
	 /ntvzzRe7qD74kpNe45KLNi1aNTZhykmMIxtviSK89rI8R4DhIPhzEY/vWl+xDHfesRoQ
	 pDEdDmrmGJSKph5Km07gganPkhLZWd+gPtHmz/kJ2qL4txj+dW4KE7HrtUekFucfcZTgD
	 Hb0G92MwY4JRcRyMPvur7b75j6LWGweQjnzvWd3omDUpUO6B85yi8q5yyxT6dWGZd3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794711196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=FEFqR+LrcVL3DPo39+xuQCQE0txVSiEwhPQ2lR4VeeI=;
	b=jDAhtlEv8d8Jmy2UJR3RCXxnZzFfDno+67mEacih7nY3AeV9rKyn/zELdBnl9YnxDQMj
	 tGBjHZVrpqq8leN0MRD0qHbs51i5sademvioUPWTwMmZJkQP6usoyxufy07E1IG/Fpxpx
	 H4IilvenyneL5WNDia3NQusY4hz3BjrM52c08HRlOlehf5Oyi0Me23T+qFaZ54r5ilADH
	 hgpstb2lVVq5uKJB8xtW8tPgsgzGNxFWRkQpskdeao8h7TVY7qcrayvmznlWWSFxMLxWK
	 nGD6nEdqSoYlS46rbjwFQ+XeSCHOSYMttkhWg0HmOpusqbpPl5CzbyeDuPv83uz5NZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcrn69dz;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6A606A32D
	for <linux-rtc@vger.kernel.org>; Sun, 15 Nov 2026 02:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1A6A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcrn69dz
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9495e8ae23aso144405585a.2
        for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 18:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794711195; x=1795315995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FEFqR+LrcVL3DPo39+xuQCQE0txVSiEwhPQ2lR4VeeI=;
        b=qcrn69dzmQolEs+h5yEiGzVJHu4bLX1DKf+xYNeVJXaDRLsor4tZEhx0QaAMSct2Tz
         LN798TXybSwRmQRtctyWLyEz+Jjw8D1neNJ9la9K39X0ZbxWbPtEJbREdwkj+ZY/dozn
         G1DTejOIXmlYRFDHgnWyoT1JygHcZjaH+ZjvOSwRZsh5R1u0YEkp88Aiq61QignskC1k
         DXDZ2yAK595kXGwUTtrSzpqB22ijBdfQrZMXI/vKtcw2O6umgX92Z2Ke6L1QcxCwAo8k
         UGtwfpzn5iCUd9ae//G54GJeHk8wUvPcwBEOmVUPzBikroIQJN8ai85vc7c5qVW1oyML
         ypUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794711195; x=1795315995;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FEFqR+LrcVL3DPo39+xuQCQE0txVSiEwhPQ2lR4VeeI=;
        b=rRWeB88XxH9K5EGRBpNpFO6upRWi5U+buT/l3DK0AVYL/ulHhRmkLl3XVBpu4DezmP
         jTlQeyx74tcEstPHXa8xsfCDe96EomaWqn5pgg09y00kquQZVHiL75jfVnNOA9lafDw5
         f4a9Mz3leBzN845nqBVY6DaiXqwOMW2uZ7KvnLTvuNa+CjvNBpPEr8JK+J6VsAfxDFrp
         QiwB9EfeL/iuT8Qej09Na+tAViyPRT1jbmdVo/TaOfkyj4cyK049Sl/ZrNNsCKbzuUdd
         +4UDCorJo5/Z2FRWKmHE3/wrCAktabtPdsFV54kmPOcANRuTji6AFH+McN6oiOW8KBJu
         4o7A==
X-Forwarded-Encrypted: i=1; AL+hErGV2FkQ+E+jq8/wNmWGmZSIskda2IMsv0uDUT1slLSJZzq9DtE1GZrXV2Ka0d9thHPEszQ15OXNcpo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YFZ6KHytQL+GOB3n47uAdoulXgooANLib1wJDUI+VAAWaYR9j
	LC2tPrELU1SmT9Mcb1m+F065+Hx0L9jy9A1bVdMHGGrqykV56Hx5GsZx
X-Gm-Gg: AYBFou1XD+GnaI9NwIwrLW+BFS3p560jX5tmkMUqJ7zGheVZ+/bkvPe0p5flBCBay9L
	/cFtZLTSzaGS5aRvnyFA6OhltiqLRjbRl9iP6zwq730dVsMEIyNGlv6seqvt6DfdSc3d/IiUBre
	CoLyaYISkcp76Or97Swf7M/YU1MybVydlLiO9yqefIwYiiX9+vVMcotrtmriyX7zz+By/Bw6neW
	UFnMCsa9ZRBig8FKPEnNmiEhTK548r7QNN9tHzy9fq3sNmN4F0vvHugBTsvbo7ml2Urth7px9QM
	u40BL22ti/kHWLS5J4gPye2y0ZIur+YhOtvQGYad6393bovP4WFsvwXGmPJwpApcuG1nZ4cwxen
	XfusTaDTp/sIzqnNDMALM5ZrXoZs16jtkvYfcKWCfZYpHWrqVmculr2NQRMMkkh3wsu5CBVoUXm
	6sfAtpZcd09kk6xIKVivIDwegZzLmvpGwRRejY5tTjnJORhC1eYMrcFK40AJ4z+O0sV0qlHrShe
	ehU64NlrMNGhIMwpU8bDAWp+dQ0yZ/U5Ar2cMEh0wGMFZ9s/DV1UpSiP4TNhw9zwCAV8oaaJ50p
	7UHdYq8qfiVShBLjJPF0qIoXW+YlJSojTCYm5jMWZlVQjae9gl9Tes1/Sr8ttjx1I2KcdDHcKnu
	PlyYMmSVGxAl2msCNs4exToCVtqTE6Cjd0dXO4Bj95OEATTiY7I7VEAibAujHcSP/jJP4KxK7xz
	s=
X-Received: by 2002:a05:620a:2614:b0:939:fde0:a71b with SMTP id af79cd13be357-9494b86e99fmr1082857185a.0.1794711194579;
        Sat, 14 Nov 2026 18:53:14 -0800 (PST)
Received: from ?IPV6:2600:4040:5abf:f200::9dd? ([2600:4040:5abf:f200::9dd])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c836156sm531348285a.19.2026.11.14.18.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 18:53:14 -0800 (PST)
Message-ID: <9c17de44-8c69-432a-a196-90a4765be871@gmail.com>
Date: Sat, 14 Nov 2026 21:53:13 -0500
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
Subject: Re: [PATCH 0/5] Add support for the Microsoft Surface Pro X
To: Val Packett <val@packett.cool>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maximilian Luz
 <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20261104070441.74127-1-val@packett.cool>
Content-Language: en-US
From: Haipeng Lin <jimmie.lin@gmail.com>
In-Reply-To: <20261104070441.74127-1-val@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 2:04 AM, Val Packett wrote:
> The Surface Pro X is a 2019-era tablet powered by the Qualcomm SC8180X SoC,
> released in three variants (SQ1, Wi-Fi, SQ2).
> 
> Patches to support it have been around in a downstream tree at
> https://github.com/linux-surface/kernel for a while. Let's upstream it!
> 
> I have permission from Maximilian Luz to use his From/S-o-b with modified
> (squashed, stripped down and split by model variant) patches:
> https://github.com/linux-surface/surface-pro-x/issues/7#issuecomment-6597291831
> [...]

Hi Val,

Thanks for your work upstreaming this. I've been running the 
linux-surface SPX patches on my Surface Pro X Wi-Fi SQ2
(Surface_Pro_X_2010) for a while and tested this series on it (v7.4-rc1
+ your SLPI + this series) plus a few fixups needed to get it working:

1. Labels for smb2351_2 (pmic@2) and smb2351_a (pmic@a) in
   sc8180x-pmics.dtsi so the board DTS files build.

2. &qupv3_id_2 { status = "okay"; } in the SPX dtsi so uart13 (BT) and
   uart15 (SAM EC) are populated.

3. Tested caspar.dtb as-is but this will cap CPU4 at 2.995 GHz (SQ1
   clocks). Added carina's two SQ2 CPU4 OPPs to reach 3.15 GHz on my
   SQ2 Wi-Fi. Please see reply to 2/5.

4. Wi-Fi: I had to revert v7.4-rc1 544d85de4dc2 ("net: qrtr: Send HELLO
   message on endpoint registration") otherwise MPSS hits a fatal error
   ~40s after every start and crash-loops. Wi-Fi associates but never 
   passes traffic.
   After reverting it the modem starts up so this may be a regression
   unrelated to this series.

With the fixups noted above, for
- Surface Pro X Wi-Fi SQ2 (Surface_Pro_X_2010)

Tested-by: Haipeng Lin <jimmie.lin@gmail.com>

Happy to re-test v2 on this unit if needed.

Thanks,
Haipeng
