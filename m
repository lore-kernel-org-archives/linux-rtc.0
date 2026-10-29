Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793298051;
	b=zl65STZV+Vwa3PCKOn3wC6wuY27ITlBDW789/XBZTlH7cgBUGkSP48oWj9+SQrFl/v4d
	 kwYQKpdx8eqgsI+CJNCdQCV6IMGj7Laep3d/YEUVWRd/5oasa13maMSZw9mnuB95Yprq4
	 Lkkjc9zZB83Uu0uWdmAgBEmrQHjrIUQ0DK1XfxTdWKBBImREh1gaxZoOJX0xlLjGunerY
	 d/bm9MUsplveuMLMK3SqXJDsTCmomL80oc9StO3potQKfVKdqsODqujZLv1XcoaTwSPa2
	 r+QNCnmmgotUnHhA4gzjXhIIaQzaKmZ8hInR+a44VvgXgJA32KcwNes/3AAx51rVA+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793298051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=ggNoVNPA2Bii3jze7tCfHt9vsP7G4w8X9UYeBYzIxhU=;
	b=0y/TdvKI4xyt4oh1U37hyr6OF/qnhhOff1Koft1Sj0imGzJ4aJWJKcMZ/SJCw2DxJMKP
	 wB2JW/rwnkN3ZjnoNdiAy9x7L930Vr6cXTSDj7sxCnvd85Yifpyt6HRcr7Dnx1X3qRTfO
	 gy5Ye1csBSKKJiOw/wp7ZntDgX2jr56YarwgYulMc5P9eEKTBgO4N+Lg3MPOSPZmHMFZ4
	 SsdkOyK1eT9N5g48Nn1p4pdFd3yLz6N17ljXoX0rdfYkm15lQe9gZPQogBFY+B+vx0xHa
	 SwNOqgauy4R/pY38GohuvlwbCrNsJa23nxKSuxoFg2vxz8oOn7XTI5lmU2uvDGu18FQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ie8aKxgX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4804C606A31E
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 18:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4804C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ie8aKxgX
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-82380b0f55dso1324286a34.1
        for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 11:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793298050; cv=none;
        d=google.com; s=arc-20260327;
        b=WDRtFBO+6mAT/WN3hlS3Aeo1mKRR82V0U1AkPmTKvedpiXXAltWZdN7eUrrxlDcALt
         urgeSj88XZuaL0tTLgpgSDZR7dkJc/eb2m/YNy9LXPotf1TDSJFdEvNgTHN//kdDCAye
         YEtRQyn/FyVWEZs4xeXqyOTuscYf/p3s15lTZ9gnpLsGbEAG9oLzdMJ91fD4DuPK4sxU
         zcsDmChHgfcS4QIqFPD8NNIU6FWInJW6G/RTm8sNxThwMNjuZxb04rJPFDqoPPxK5Asm
         VmZRi5tEll7Tat6dPBnwrwb/0qJD88fAJ6yENU5B78VUCL4Saf+PH0DwAAZIa+4kRf9A
         zOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ggNoVNPA2Bii3jze7tCfHt9vsP7G4w8X9UYeBYzIxhU=;
        fh=23fKxIbVp5X2kLPfRQPGCCbg0Vo3VCD/YssaKXaoqEw=;
        b=mZNLbAk6CTaja7YNQ4SOwJCSzCzAlcgva4xTTylGHB2s6owmqMG+ihb2CEnfwnNOwh
         ucdLZcDG4YwdtL6ygIfIOGh8+I8VjOmFl44Qo43+JCx7cG969J+kB7+hogKusH17BsyN
         y2cSgvhQHAQOWbnVfqSyC9I4rJ0KR8D2mHPYR3W0N+Vabe1YjD2PeI1S47XZi4qMfQ31
         AF6sRPBF4jTlZoj8kd8MReP654aDw/qEC/yB7TeuU3vxsEEqxYyOUJh3SHSUgTG4Q7ih
         9iBNh8ftHsEVC6hf1oy7aOWgRmDUmi3mMpdX02SSF/g5zY/2qHPI5q2L6HyIgOjYwH3l
         fW0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793298050; x=1793902850; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ggNoVNPA2Bii3jze7tCfHt9vsP7G4w8X9UYeBYzIxhU=;
        b=Ie8aKxgXYZgZ4zONjSH1zfhtUgHtVC/N0CsbnCfi0La6zmMvQnQsQXxfu/Sg6rxyaI
         bLun0mjxBmY8WO8m3pLkaUF/SAvrOAh9tFOmo4p77f+n/Zv7yZ3jYEuYC1wYg16ZHcIV
         0ttgdSQAYmx54JiEeQ0iW1oC2ZxSyeobAGlTYF9YNO79BcdWt8E7SWocgoXhl97SjlrT
         YBx/Ly6ZkD4GdUlp2dD0k0QF5b6bs5Wzr6ZXhxxTkeESAeSMFFJ8zYad098BZHbTtdhH
         kEBm7Jcy2ewx0mA5JrN7OtVmnZ6FSbbjH5a7JBGfZtg5Nb9rIHWLcmk/xpvUgfLZlq8X
         GbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793298050; x=1793902850;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ggNoVNPA2Bii3jze7tCfHt9vsP7G4w8X9UYeBYzIxhU=;
        b=nHO2/k0pPlYFtzmQd7g5M2u70AqzEZEoWCo7yPDfwilvwxBMFkoss34oyqQ763lIHf
         KBoGWNN2Cn6Jr0G1xkMFWV8TvtPLCqBG+iA3ZH/Qlo9NU97g7A+oI3t4mn2qt6oOp5bB
         kJsIjNjF+zdyqDS402ICVBYEaAM22cLYfp+XNr40xB+6p5Tog2D/IVQDQFK3c7AuKmgF
         vNBvpU4GU1L0Xse2ZjJ+3f/1whuiC7Kh1nuIzW+H5beBesx5v/nXYEAkDd5enSyi/TI4
         hKCPEhMyie9UoK37cnKCx4Dw9N95jI1JdObxAWuZI0Ufad2KW5RPUVslPGEruwru6FUB
         UVyA==
X-Gm-Message-State: AFq9FYI577ykgYU/YUeB/9uTCmL2nRRgTuOynrKAt2kdk6TBbL5dbj3v
	DFFq1Lq9iQAHUFXWGnk9fUDr+94HEsvlhVlZIruafZmRFzEDp11VY7ja6tbpjuyLaZQ9cD+SCLS
	ts8hIh1nVhjUbnog7Z1kedyajvVljdftoqw2V
X-Gm-Gg: AYBFou21As3PooJhspzms4Z9C82OO6EUR9V9be5VksShtaejqYUWuuY+mvNhRbzVwK1
	pooudTHfcVIxRXZgITyJW6i4MrpMofPSju6MXIkZOA0L3z+jCcBaiG1PzTARhVVD34BY/JL8tp5
	PEDzasHM47yURxd2CRkHw+vM0rnKIOVDEeY98BYMHtNqZBxAX2kKpm95n1bK64KveBYqirzv/qy
	XHpvE7fKCgCHiReyZvBMB83rhzIt7xOvwI/XA3kCJl2OiwvEjdduLXWB1qlHtajqSIlmFpkY4Bg
	vWmou56/DSSTL0f0J0AldaMIM6HOgikYRCEJutxXAP6Qhs5q6iItzga3vKPbjXfMhCMo6oSIKA5
	RKNrvlBEYvpKBkyXIGhUgbI/iAV3tSiKnZDIr
X-Received: by 2002:a05:6830:2e10:b0:835:63b5:8b7b with SMTP id
 46e09a7af769-85ab9873be4mr5674733a34.10.1793298050197; Thu, 29 Oct 2026
 11:20:50 -0700 (PDT)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029132339.925021-1-alexandre.belloni@bootlin.com> <20261029132339.925021-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20261029132339.925021-2-alexandre.belloni@bootlin.com>
From: Bruno Thomsen <bruno.thomsen@gmail.com>
Date: Thu, 29 Oct 2026 19:20:34 +0100
X-Gm-Features: AclHuK_hxeJmxs8OSnBxPWTgkT9aBV9FYIaOOO8Fd1TAmXsqXcLas4MA2equwKw
Message-ID: <CAH+2xPB-oaN=m5RuG8pkw3W162Px5pRypNJTSHWEpO5yt2RmEg@mail.gmail.com>
Subject: Re: [PATCH 02/12] rtc: pcf2127: use sysfs_emit() instead of sprintf()
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Den tors. 29. okt. 2026 kl. 14.38 skrev <alexandre.belloni@bootlin.com>:
>
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>
> Use sysfs_emit() instead of sprintf() in the sysfs show callback
> (timestamp_show) to conform to the recommended sysfs attribute
> formatting guidelines in Documentation/filesystems/sysfs.rst.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>

> ---
>  drivers/rtc/rtc-pcf2127.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index ff2023908f5a..49542cc53411 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -972,7 +972,7 @@ static ssize_t timestamp_show(struct device *dev,
>                 if (ret)
>                         return ret;
>         }
> -       return sprintf(buf, "%llu\n", (unsigned long long)ts);
> +       return sysfs_emit(buf, "%llu\n", (unsigned long long)ts);
>  }
>
>  static ssize_t timestamp0_show(struct device *dev,
> --
> 2.56.0
>
>
