Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6259732B112
	for <linux-rtc@vger.kernel.org>; Fri,  2 Oct 2026 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938795; cv=none; b=ntjkXpfzblv9iRXSuFdOSkK4+ouoxANFBm6nDQ7T1lh7eDy3PxX/GMyRP0M8dU7ak26M7oBjxoXBlBXXi6dhevGVjTLiLkDG7QakqFE6L6IvEuD7VnCsQ1RclqPaWIOV5XC49jnbFpxHzUcwZ2h7GKbSvzwTvqV1SSBna6iHX4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938795; c=relaxed/simple;
	bh=6DtOtOl+J4rk6w07hVxeu29SBmqYHvwDu6/lM1zpfm0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QYz5Of6ZQjUGNHVNbRrcIUBwues4zfmqNi7XmrGF9I8dTdeCZ4hrb1YjwbIYDTP0VoNis+6qKUcBapzAmXbhzsNpYCoiFm5F0ab6kOTeqAse4qYCH2uGuZ/nBIsv3Ges2u+FPqRPP7p4rQ+E7WJGOCr1pTktTBNCnGiJHC34t08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMxs/skw; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMxs/skw"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4834977ae75so4698590f8f.3
        for <linux-rtc@vger.kernel.org>; Fri, 02 Oct 2026 03:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790938791; x=1791543591; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=epdy6ouxIxMiFOK1ZAb3XC497bNEKLWzpO0WfXMjJnI=;
        b=dMxs/skwL7wdsayMf4G6MEjmmx8egy49Pq1Z7SRWVSDhB1MAQ+lXOvXBYGeCdhVR6U
         HWUTD510/v9vsW4YaHJfxFwhUys/TagUa0yWAXgOCmoqfZJADTEBDrnz56D5e2vc0FVo
         WKplaVSz1EbWqT5cwK1qxNKe3Fn4Jj6tpj50S2hZ2tOZFLjcIopro7tmDNMQelSvPGy2
         TSN8OusXXjDSUhjEFzl0Y3+RmcUHaTbsVyZwXC9i/8NZeY0tpxZOYxNUGzIWUrNsA0G1
         IiWtImU+xKSyz9ViG/ZsFSU7TYQd0WUfd2/sGmkeFkD0LwHAkC9tzqh8qdLkrNUS0ATK
         IiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790938791; x=1791543591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=epdy6ouxIxMiFOK1ZAb3XC497bNEKLWzpO0WfXMjJnI=;
        b=Jy1DNKIXrYPn+TO1fTaMgwXeXVMfaWaNSp0gsn2StVkE5arz+Mp6uH6u8+gxX3Q+IV
         pNUN3vPhGMVIhEan/+lh9crBI+KoKES/CB74avJ38hRjuPjV5QcSWpuF8PPqXfoRaCof
         wEMbIubgJ6gPMhwvcjJUR4l8RzS/GK4zfeiy/zCLDaQjqF+5J2j0bLhAWDvrL8tCZHgi
         0vmYzrhRVSaSqqv8cbbUJWjuU0Sv/ZfwCwcUozwJ+rfLBrYbGqDQsfO8U2x1N/TF73YS
         76ew+MkwCZMysYjFhCPC1Eg8tXSz5i5CoAhVdt041R2oGcsp5dXW5FZrXHBnfhT1h5lg
         Wcfw==
X-Forwarded-Encrypted: i=1; AKwUvBxfrNlgbm6K4dH277pzXpboDNcFuESjvzJfs/JrxUWBYscxkvua+1R6aGY32/6JSBqT/LbbgF+4Vbk=@vger.kernel.org
X-Gm-Message-State: AFuF++kWee84QgzRgQ5L30eqA3StSfN6OUw4qGlmV2ZC4QWE3IEzjFzV
	JnxbwJ+luVGXBxWnhhsaj5yBrOyXS+ZDbokl9Xf9tNVXYJ/3O8Lo9Bpf
X-Gm-Gg: AYBFou3FJJjPQ+4Dy5E8mlZbW/1vnZJ9CddKLAzxqOVHYwvrzpLBVzP4VOER4GrlEYW
	Ztv6Ce+8oZ6k3hm2l9gMQAfo/kmPE9w/C/hycRW1izRzyROUMuLL+DYvLv2NBu6P9CxQCeP2Dl/
	XYSwh328nq7cewovYyHuzlPIE3+YNFzFnGK/RscPFPDojOyHOTbYRdWn+1szg285bIXmoGRVRRk
	Bpjl8zA5oAF3wJ/eQs2fUtbiyMBSW+gvtZm7V0KZOPjr9sMu5+uBTe+h1AB+Ucvs3nTFJsWNail
	gLNfcnLZX3ov554zl0rl8paGGx6io4EZHa+IRFRzxX+yRV8Td9s2duJZWvBczhTH1VLc8WiOUTv
	8t2/QwUp8M/MbHwv7FVG4tjhERAIOEYL1VbOW1e4kZWVyu0P82Wh6KLAcy2yHcFYPPuEdJrM7fb
	gdaB2vXfsPdtqGoMLm9lcEtGCLpRLa2OztXopHWRCGRs2OntzwgZvXZq3o3+hMnt9Ue5g=
X-Received: by 2002:a05:600c:a306:b0:49f:f099:6f8c with SMTP id 5b1f17b1804b1-4a0275758cemr31339585e9.9.1790938790757;
        Fri, 02 Oct 2026 03:59:50 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280c8bb0sm78160685e9.11.2026.10.02.03.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:59:50 -0700 (PDT)
Date: Fri, 2 Oct 2026 13:59:46 +0300
From: Dan Carpenter <error27@gmail.com>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Linus Walleij <linusw@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Liu Dalin <liudalin@kylinsec.com.cn>,
	Deng Yingchao <dengyingchao@kylinsec.com.cn>,
	Qin Yungao <qinyungao@kylinsec.com.cn>,
	Luo Qiu <luoqiu@kylinsec.com.cn>
Subject: [PATCH v2 3/3] rtc: ftrtc010: fix integer overflow in time
 calculation
Message-ID: <42C8FBD59AA34EA9+20260827080320.3351155-4-liudalin@kylinsec.com.cn>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827080320.3351155-1-liudalin@kylinsec.com.cn>
Message-ID: <20261002105946.8rdteIpO7uWGEcTlS65F8iSi4gsRoXi2kgq8FTSaDPA@z>

Commit 8ef8e9839a23 ("rtc: ftrtc010: fix integer overflow in time
calculation") from Aug 27, 2026 (linux-next), leads to the following
Smatch static checker warning:

	drivers/rtc/rtc-ftrtc010.c:75 ftrtc010_rtc_read_time()
	warn: cast after binop

On Thu, 27 Aug 2026 16:03:20 +0800 Liu Dalin <liudalin@kylinsec.com.cn> wrote:
> In ftrtc010_rtc_read_time() and ftrtc010_rtc_set_time(), all
> variables (offset, days, hour, min, sec) are u32. The expression
> "days * 86400 + hour * 3600 + min * 60 + sec" is evaluated in
> 32-bit arithmetic, which silently wraps around for dates beyond
> approximately year 2106 (U32_MAX / 86400 ≈ 49710 days).
> 
> In ftrtc010_rtc_read_time(), perform the addition in 32-bit
> arithmetic first to preserve two's complement wrapping for negative
> offsets, then cast the result to timeu64_t. In
> ftrtc010_rtc_set_time(), cast individual u32 operands to timeu64_t
> before multiplication to prevent overflow in the right-hand side
> of the offset calculation.
> 
> Fixes: 1d61d2592c1f ("rtc: ftrtc010: Rename to Faraday FTRTC010")
> Assisted-by: Sashiko AI [static analysis]
> Signed-off-by: Liu Dalin <liudalin@kylinsec.com.cn>
> ---
>  drivers/rtc/rtc-ftrtc010.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
> index 19e6333bfbab..b29c96be40f4 100644
> --- a/drivers/rtc/rtc-ftrtc010.c
> +++ b/drivers/rtc/rtc-ftrtc010.c
> @@ -72,7 +72,7 @@ static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	days = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
>  	offset = readl(rtc->rtc_base + FTRTC010_RTC_RECORD);
>  
> -	time = offset + days * 86400 + hour * 3600 + min * 60 + sec;
> +	time = (timeu64_t)(offset + days * 86400 + hour * 3600 + min * 60 + sec);

There isn't any point in doing the cast outside the parentheses.  The
other chunk probably does it correctly.

regards,
dan carpenter

>  
>  	rtc_time64_to_tm(time, tm);
>  
> @@ -92,7 +92,8 @@ static int ftrtc010_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	hour = readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
>  	day = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
>  
> -	offset = time - (day * 86400 + hour * 3600 + min * 60 + sec);
> +	offset = time - ((timeu64_t)day * 86400 + (timeu64_t)hour * 3600 +
> +			 (timeu64_t)min * 60 + (timeu64_t)sec);
>  
>  	writel(offset, rtc->rtc_base + FTRTC010_RTC_RECORD);
>  	writel(0x01, rtc->rtc_base + FTRTC010_RTC_CR);
> -- 
> 2.43.0
> 
> 
