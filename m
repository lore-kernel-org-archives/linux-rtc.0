Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600213;
	b=K1A8FdxWm/FDriq6g6imfzecGYKZUERsUW0qP31BLbgEdbsHqch4sNpy1A+eZlyvqlvp
	 +zQBZvw3jSSUi76BCFr/u/VAYbatmtxI2vVIZKwX4rL3q79sDgpqLHBX9xV6kVtokrxQT
	 odCpe+v9GMEdoqDbnCwqF0qEmwY4FRe8daun6EK/jionnhcZjNV06amlfi4F14AbyivO8
	 w5/R5VtWnxZGGBOUJZgHtjanF9A+KGWN7qLGCDxQw4jWKW/V8azBB3ah/8ISFSOUxOkgi
	 pKJpKM2/0+zBJ+A9snYpQIgj3U13B/ofhrmWLkyVZ93m63WTKqunQJYTfoGdQTH9MNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0oLkgc4LESe1RA5rsRbAFuQhuNZ8h5rAeMBrxjfEeoU=;
	b=0Ig4O+NUNzFu40z18DTzYMvYtod+9kemO/E6ZR14jjmFy6ZTCp7VcoWOkZEA2GQNhQUx
	 Z+x5qDarXqvP4MlSTYEtWLphxIdwTFtrR2UmJzIPGk6YH9RWZZC1cVW8BKqaKROWDnncC
	 U5FYKjqP1dcNPw4tA7f8JZgh39BlIjXnT7Xmgd68g2OLU8DrxJNgcXtfRSJbhdLUCnBbP
	 7r6b6ym59SHlcwMTu6QahXa9pbGip34z89OQOuIlV+3ljncNOGvBMXtGDTT/30CRRiv3u
	 XAPMKd+kzl3dk4hYDw78VDusVRx5IaB7l0GC8Q62hjwkmiTHdJXAbp7LHMcnDgKd+9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Z9P/LEaz";
	arc=none smtp.remote-ip=74.125.231.134
Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019A6606A332
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 20:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 019A6606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9P/LEaz
Received: by mail-oo2-f6.google.com with SMTP id 006d021491bc7-6ddeba3e85dso400450eaf.0
        for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 12:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794600212; x=1795205012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0oLkgc4LESe1RA5rsRbAFuQhuNZ8h5rAeMBrxjfEeoU=;
        b=Z9P/LEazFr6KVed6bhtpiLAGhPrXtfYhM2lV6DlzRTRiqS7mbJew5QySGoG1DM5DBg
         w/Qb+/GpGCjNrQHB8Bc3EIuAAxGD3zwav8las1IxrGyj5VzP1iW7ZAhBN1QRSZQkPxyD
         yeioWvEr5SI4P3Vq4TSb1WYol3vNnYv9cUW7YFHwShUpU6KqQIsl2AJxNiA2iaEqv29I
         wGAR5gThxr1VOyq5sfocJ4qmcx3g7NKpIcUi1cyujjclHNzEbhFA5CWvNFkgXOupYv/3
         WY8gMlrYVWAdAQ2/57OJ+l5D3YANZ/sL/zsFE1SpwiFdmO3DWke+LLQoS/jzS2JOFDa9
         SKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794600212; x=1795205012;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0oLkgc4LESe1RA5rsRbAFuQhuNZ8h5rAeMBrxjfEeoU=;
        b=CMOasn3NUPhbATa2GjjDKk7JtIYdGE5dTIJ5OQdEcYLK/Ttx0W5V7+fdWyqLxUyA/v
         UkNUTUc08FahhVPq+LjtmaKppzkT0n0HKdtGjLiyuHX3eqP+iI2ruz4fucHNkiK9/l1n
         goQ9hdjSYOJvxmlf33hAvddYk6ln0AxVPLRNhOl1YhcK+wqFTYM2e8JkmVxzmJitPrku
         YexaoQOpILrmgpT4l9WLjvyRwlgwdBWe8NpcP+2tgB4Lef9IuM0hNUjdEx65esUr6Q2f
         gHl9Wi+z7haYca7/D71iGkrf+/GzWoY3Vd/4Sby2dxYZ44414V0G8/lCBEW0W4uvc3cS
         dqlQ==
X-Forwarded-Encrypted: i=1; AL+hErHY3/8/U6esJD6rgJAcluQ/zphKbp0XpPTVQ4n8l6JV6TItNI+lonnxp2nR0IRwwLyf+4SdGb0nugA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wPX22ZjNUw+uStjC+Kqxy1r2192RTeKy/mYl1hHgv5WnJj8Zj
	snWpi1bo4PfuszpJylGI4g6CtKZjPi+VI7uC2lR3vbkQOBwiy1NEqQB4
X-Gm-Gg: AYBFou1Fpk4VfJFzo2nehAOZTaotF3X4WKzBrcWWWbs5spowI4vuorw3eGJoUtURunU
	QIP0f1hO1YqFMAedgoedQt29JIQmTl4AUZkn/X9inIWE59eDfGzHL2i+raxRD2c8gR1cqtCt54s
	38iL4s3ABjbAqocubQ0Gxi5ekC9W3GzC7oNV36aagBTmHUhrq51Kv2s384UG2vkYr8jGy7Tzhn1
	6tAbDEyO5m1Bmc8+bbtziUxJGIsneoakiwG6CDFy5I7lXlUJM+SiiWYClhE2GouPmPZfoMVGF0d
	uGIWoC64Ha0N6d5CAwXuHbmfZTmr3KdKkvxIdCkXvzpDBYpX9cjhoOX/vmz/ENhLreIhY+aBO9Q
	xLlsJSve8xjz+0YxKImi0MTXUUwc9rYQyRd1l4cDISidKtQWz9skMGjpyq8j6iLe8g9MhXawpDU
	fH4fXv5wCwe6oWjNY0mbCgampifjKiHAXkrTfqdBdRkJLQjqDZXVC7O5YJbRncqKgxhUbNBqLZc
	anvj1hO+SXqXJTyiadjKmUKg9e6sCsqbGumBXJ3vXIZJMVVx4WTFK2lsPK/pzCFAsl2Klrx122M
	gwJjVbAgrhGmZOT0olcey1whkGepezBVMhJCTuVm4H1y6JnhwIclxK0JpVVKKllahHp8H5auHTo
	6ZVUUC2zELojA9nv4/RFnf/R2bwhdieHnlpDYl8Kx
X-Received: by 2002:a05:6820:f025:b0:71a:ce4f:4a86 with SMTP id 006d021491bc7-71ace4f7613mr375277eaf.56.1794600211873;
        Fri, 13 Nov 2026 12:03:31 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab4335912sm2485972eaf.13.2026.11.13.12.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 12:03:31 -0800 (PST)
Message-ID: <a6bc9228-8e81-4f16-bd26-2d9c72e9998b@gmail.com>
Date: Fri, 13 Nov 2026 14:03:29 -0600
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
To: Lee Jones <lee@kernel.org>
Cc: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Eddie Huang <eddie.huang@mediatek.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pm@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
References: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com>
 <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-2-9758f38d7053@gmail.com>
 <20261113185047.GH6323@joneslee-macbookpro.roam.internal>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20261113185047.GH6323@joneslee-macbookpro.roam.internal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 12:50 PM, Lee Jones wrote:
> On Sun, 01 Nov 2026, Ryan Brue wrote:
>
>>   
>>   struct mtk_rtc_data {
>>   	u32                     wrtgr;
>> +	u32                     con;
> These are terrible variable names.
>
> The nomenclature should be self-describing.

Hi Lee, two things:

1. I have a v2 out [1] from early November that fixed a null pointer 
dereference that Sashiko found. I can spin a v3 or resend v2 depending 
on the response to (2).

2. would you like me to update wrtgr as well? I can add a patch to a v3 
that changes that name in addition to con.

[1] 
https://lore.kernel.org/all/20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-0-19ca72815374@gmail.com/

Thanks for the review,
Ryan Brue
