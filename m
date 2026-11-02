Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630193;
	b=eDv0Z0prdFLpbYvwQqSU2orHHAfsmFwuiNCjUeIMYEAFmxjkdIPomekxTmO5FFxiCyBU
	 15sS+e9MJ+KjOYCrbqexhkQz/6vYpisW2mh6M5xB+34tV6CWMUmNB3MP+uwRyTzrcbbta
	 9JUUgS4ldF/an8fMooafd1YVDfWzl4JKHePKpXqfJ4ADqoTklqALrDbaibsM7lwWhtcbs
	 3a/UaPFhq2yGv8U9bj4NDfUyxlHE7eKK8iBp673ws7meKm38pOsbnGkB97YQk+ZR3uovO
	 eBhrgjqhYhwTYxTYdRrxTmSUCm8n+cK7NjiHBxLCFOMuTcVeDmz5PP7WFZiarFEp0yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=O/U/gtv+fmTdKgkNES2DeDqnFxJ1hQs20tgERiKWY4Y=;
	b=P14g2Cx9RvwPDe9c7wu4Rylu3fTbPBsBfioFat843JEDqDymnu4KJb46ngTIsBL/ZrHM
	 fFxSciuH1UFXWH0PPV42lS6ysp8UvjHF8btQMPkAiBIqSo9I5W27stA3PoFhMpTsEkQ+U
	 72xbPdof8kJLWLDR5XS1EmzzdxnDASMKqJmkqRRMB1C8RU65Titrk8jNnyA5XK2hYv6Zm
	 NcQ1Qh656ADmwx9RAYgzosy68fLQMJEZQR8qYQL0ovaRAeyFEsBwBrXG9V81REpgSB8sk
	 uqruWQdIxnPcC6wpQt1JL8qJVh7tphJEzwFqeMzVk3OweGVctx47Q7P+l1Gg9Lvo5Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGvuWvXA;
	arc=none smtp.remote-ip=74.125.231.136
Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD22607824B
	for <linux-rtc@vger.kernel.org>; Mon,  2 Nov 2026 14:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCD22607824B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGvuWvXA
Received: by mail-oo2-f8.google.com with SMTP id 46e09a7af769-843c8bbfbc4so1374916a34.1
        for <linux-rtc@vger.kernel.org>; Mon, 02 Nov 2026 06:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630191; x=1794234991; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/U/gtv+fmTdKgkNES2DeDqnFxJ1hQs20tgERiKWY4Y=;
        b=yGvuWvXAnv/ALgw/ng7DiKt3/v4Bc9Py6IomOc07OmxQNEgtiT4A+vgouwG4lOZ6Cy
         LcKm5jMK2iGs8gkNO6KkLjoe4VTlGr1VLROmHSArFpPnekaAhNjMnfl8O49jixZvc8uh
         Xcz3Ki4nVuRdlvI19+/kn03r/WzAw2tueHb6hz12ExZK71YLMGaXZPyn8mJu0Nk+vdaQ
         yxDUnxVqJVHc7w33XlZcEdmxNXf8gl5sWb5MDUkIFUoiCNDq8saj59W4kdlC5E5FTxJn
         U5rwYsh03vOWfF7u8c3TxcgQzoWhkH36cOn2dJJ1sWe/e3ldKpsapOeQ8XDsC7m/CbmS
         H6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630191; x=1794234991;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O/U/gtv+fmTdKgkNES2DeDqnFxJ1hQs20tgERiKWY4Y=;
        b=me29as5nV1n6qlBlKDo89h7EFAjutY4qcUq94rAgwwl17y9OdGWxc5dDBwlEdxZf80
         PYj1R48TC8ZvyCLfyNtBZCjQAOjPtkJAdMHUTI6dbl13MvRC7Ws7sMBdz9wdeduLrFLa
         P7+VKysfgQ/NbkcYw7NiaZ43nrUnajJe1mcwjOftMg+4H/QMeuRmbHlerIeq3HNs6RlI
         SM16+g4Yq1112dxniSSNMykzRRIxRYg+Yx5vWP/GgZmXRK+SRtN5pUx6qM9jpVMoJY3u
         PRtWzSQy4X2MIWv+EFvQQOwW28RlTYQHbV7fk46OAgmX5qLY+xaOR3cHb8y1PJj827zh
         v7sA==
X-Forwarded-Encrypted: i=1; AKwUvBxGR4u5ibuJDESJnPxOpxbukM306ja/Lc32zq8tT55yJIc1rsPqLGbJvfWyOk54rVv07sKukczkPqw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNUBnGXei8mF/xxLzHmot8IodnNrU/KN9f31axZHfWQmVW1W33
	CVgAXtsTTD/ubtDRwX88MsIoobrkun2xYtaqEXSzb24a2tzLYGuroBHo
X-Gm-Gg: AYBFou2tCojP4uvVIDg8y1t4T0mDJcB2bz4axd7iPIW/zSPWbVvPTr1BywLb8cPdmu4
	6wRc4IGtcEpZyMTcpqlSweX67NoI8BHT6MTVXOe+Ns3nspLPyRsi+uWrhmbsam9oKUES1FNepoY
	sQVw+QyuQPEvcFW9wKiQ7T5SDewQPtSu1v7YlrVgxr3X1mAby2StETzywt95qqIGvx9Ps0+RM9P
	2jd+fEowzJY/4pGWEZ15qKs3Tec6v8ztMBTB7KXbtSHKIjQswlMU8L1N7E0Qxny7djl+pAu2HDM
	Jat81q5QZ3wnpd6Pe/6zpcclBi8JGbIlNgXtSRiMUiD6F7wUcdR3nOHXwmR3M3D7sz8Njpqp8fg
	0iUbxub7ZjcUvlnwDnqENUFB07Bi1DTggM0nCc8A2VsjGJqPRgBJ+s820doINMNJo68O6ySBhKG
	M0D+scX9BQq3dF/LGnRAUia1A1g1Fgzy8k4UKwjDkWD1ibogNvEFRbJH63MOhrfzhwYP9KmcO59
	SEKFi7Nr4E4IcxezBFIyrBA6Fi97QN+Sgu6sdSiZOYlEjg7dH3HAqc1Btzm0tcm5anSnVvAkQ3+
	tru77J+IjprTRG2tghiZnMKlxaTN64EKuFrSfNhGzjEX
X-Received: by 2002:a05:6830:82f4:b0:81b:ac5b:ea17 with SMTP id 46e09a7af769-85d364871femr7316643a34.16.1793630191638;
        Mon, 02 Nov 2026 06:36:31 -0800 (PST)
Received: from ?IPV6:2600:8804:5716:d800::f01a? ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354985b2sm9189411a34.11.2026.11.02.06.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 06:36:31 -0800 (PST)
Message-ID: <eb5b989c-0308-4721-b55e-4f179b8f13eb@gmail.com>
Date: Mon, 2 Nov 2026 08:36:29 -0600
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
Subject: Re: [PATCH 2/2] rtc: mt6397: provide the 32 kHz output as a clock
To: sashiko-reviews@lists.linux.dev
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org,
 linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, lee@kernel.org
References: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com>
 <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-2-9758f38d7053@gmail.com>
 <sashiko-outbox-192928@kernel.org>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <sashiko-outbox-192928@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/26 11:44 PM, sashiko-bot@kernel.org wrote:
> When pdev->dev.of_node is NULL, of_device_get_match_data() returns NULL.
> Previously, mtk_rtc_probe() never dereferenced rtc->data during probe,
> whereas mtk_rtc_register_clkout() now evaluates !rtc->data->con before
> checking dev->of_node or whether rtc->data is NULL.
>
> Should mtk_rtc_register_clkout() check !rtc->data (or check
> of_property_present() first), or should mtk_rtc_probe() handle a NULL
> rtc->data?
>

Yes, good find, my bad. I'll send out a v2 fixing this.

--
Ryan Brue
