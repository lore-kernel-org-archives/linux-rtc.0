Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378459;
	b=0HJMA14LnF/wFLPO/V9NnrL16w+g5ln7ZQWVD0Syy6gJt6ZLwl0VKRQvBg7VvUz17IUN
	 OLbPaRNmOG8UyTMSm2gOJHwWVWPeFRAtWYcG8VVeOs9aov9fcaou/QwwdQEMAQjuCj1gx
	 h761R9DHk/ChWzKQdB5O4UheMI0nMjLDOSH575mv2sS1sujmWw2rAiry5XA3+ORWTh7CM
	 RXPICJ0tn9A1rf5y14QCUJ5Qy6HxrBh5aMCEUZ2Ndj2j+bQ4J0b4YobNmt8ngBgoGPNFQ
	 LpMnR23Ip13Eq7vFciZGyVwTlF3OkaJws9jZ6Os0DwYwZF42ZxLwVnEiEQjwDaVcOEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=5m+I6rYXBG7EhF+vMUUKhGoNrZYiSUxlZhibKxKxcZ4=;
	b=178eJp+CFFkdN2/0azCBJ99Hn/ztNQyt1A8X8sYD3agBUVpu02n+bFKJvFip0DhOZ82Y
	 E5/axFCRYMcPm6tvv71XNC4nnVAtlAQIGOwkKuFVWOkGxhTdpUw+mYu9qHWFMMMUUYZrA
	 /EGI52ulsC6+cNU88U8vSZ9HifLhHA8EWK3suHwU2QiUV43iRzIyMa/ZfZjtvlz+QWM/g
	 D4sqnnz4YUVg3rGNPEQg5fCvsfmblX+8VSSM+GOg1+N2q9iLXz3FyZpD9fvKi1l+MIpkF
	 pnkteEISYfNIdpQtI82AD9Cz0sDPCXZkDePYk1B00Xf91HDSrywI7WJZ1cCcU5gx6lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W9X0lQw4;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66FA606A31A
	for <linux-rtc@vger.kernel.org>; Fri, 30 Oct 2026 16:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E66FA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W9X0lQw4
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso6184435e9.0
        for <linux-rtc@vger.kernel.org>; Fri, 30 Oct 2026 09:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793378457; x=1793983257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5m+I6rYXBG7EhF+vMUUKhGoNrZYiSUxlZhibKxKxcZ4=;
        b=W9X0lQw4SZf4yT54C8AYi8FwKxsLcslJtoO1txlZUg42yAT4Gs81viAZNw45ENsrJP
         1AvSfjHM16AS0fXeBjrTmrSN86oPyYo8Uo7qAz0NW0vDo9Y0+3KyH/aCkaRngScHtrXT
         G6Eg3gPIyckVYZUaw5osNAVY5U30HoHYjgEKV175wA/M3ZeA44e+CkYYu/B6UG1ZHu5m
         mF7HN6vWlxRhH93u5imxWx+K/ClGWlm4l7gK9meXFXvdHBcXbcJAWhR1u9mBY9fe5byW
         kPHp+6D6fQuywAlaTYmOsd0jbr5MdEBf0hyEqe0MDeVI5YjLZIdM7eOGsRbpMmZsPPxT
         ox4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793378457; x=1793983257;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5m+I6rYXBG7EhF+vMUUKhGoNrZYiSUxlZhibKxKxcZ4=;
        b=ZSbx1oBOlmHWLehSdwGN+U9uruqCJyru1E5LOoWNpJF7NazleMBQ6BkP6GowtXITfc
         I3a1nRPhuDrJue3R6Syfni0cJvItYrys4G2QmRDZ4xhsrvfa88zBD8HgJc0n+lh8w3j4
         YVbWxYE16BXIy5v/ntTWFCOqpat1SY634TM+jwkLmGDOMXMwp94AoRew7CAcQCMQRolu
         e4TWkPBKgSf7aIHG7Pr1O2BMiQhBO4uYhLriPRfRFzeHbbw6bsPWWy2D037gZa0ZSiop
         KFQdynu4FridPkYA01N+jinueyDbcZ+/+5iVQgD/w4DatP3A7ff9XiorOEQ3gMBqVI8U
         0CLA==
X-Gm-Message-State: AFq9FYIIMhM5L38RxjNzIpAfPf5EK90AWnXxJf/LOZWhcxdCrObhETPz
	AqvraBOYcsfCKipfSwSujrcTzSluY9BPmV6wIA6VfMv90bojE+2yPnLB
X-Gm-Gg: AYBFou03rPdajn2upYQBKBFL7KKjIEdWMGspp65079wUH79r0e8B/r2+A9bjYOFu9Pn
	bHTK1q3vshbfJRCVQFzxygdrbVhp8Rjc/uL+kjT9F9jYnPwF94+CSDZ2VLEQNEbr971Y7l/vtsa
	eyoZaJ/ZU78NaqtTpj2p+26keKsnKlVloG6TJpgR8Ap6Y2ySp+5ZyAr5DG3/IsfP8SrAv8QvlYG
	UTVz0UhB5Uul3bHbqiuOqlArYO3Tc943NILTlYidn5eMZRtv2ca3IiWcV6i25cnxBlM80AJpQJl
	z2xGyo+rwGwpvIFu6JG3xbi+TfTt16ejakW3UoXCPHSlvrbmt5QpgN1RZmlllHSh9hwp41y24Gs
	54oGg8rQJm+JTwUD/mknxhsXrRMj70ZnO2c9fXOgNYGMetK2HeeFwJVmOzkJ9vmmMufRuODBzgz
	I4vaAjsB11kMgXKC1zlFSvEGWivT8C0uARcT7vEDb3Jqy2E8nf+e0q0yUP89kYZQ6Bqla1n4fSf
	yNH8YrclDe3spWtgQvEY1oP3Rtay+UDfoe6k6TKLfLyMV6v8TUtguzUsHbO/qCE0ZmXyMm/yYfy
	DP89leHBHf3slDHtQDFgKBuXHyzyFbjC3RoukQoboihB01UbtMFexc+alSGd0PCTZA==
X-Received: by 2002:a05:600c:8b66:b0:4a3:5a91:5f61 with SMTP id 5b1f17b1804b1-4ac1793f8ddmr66810645e9.14.1793378457283;
        Fri, 30 Oct 2026 09:40:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c76507sm74032325e9.10.2026.10.30.09.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:40:57 -0700 (PDT)
Date: Fri, 30 Oct 2026 16:40:56 +0000
From: David Laight <david.laight.linux@gmail.com>
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] rtc: abx80x: use sysfs_emit() instead of
 sprintf()
Message-ID: <20261030164056.395340bf@pumpkin>
In-Reply-To: <20261029132339.925021-6-alexandre.belloni@bootlin.com>
References: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
	<20261029132339.925021-6-alexandre.belloni@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 14:23:29 +0100
alexandre.belloni@bootlin.com wrote:

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Use sysfs_emit() instead of sprintf() in sysfs show callbacks
> (autocalibration_show and oscillator_show) to conform to the
> recommended sysfs attribute formatting guidelines in
> Documentation/filesystems/sysfs.rst.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-abx80x.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 1c69d0e2f940..a0d67818eb58 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -442,11 +442,11 @@ static ssize_t autocalibration_show(struct device *dev,
>  	autocalibration = abx80x_rtc_get_autocalibration(dev->parent);
>  	if (autocalibration < 0) {
>  		dev_err(dev, "Failed to read RTC autocalibration\n");
> -		sprintf(buf, "0\n");
> +		sysfs_emit(buf, "0\n");
>  		return autocalibration;

That doesn't make sense.
The return value is the length of data in the buffer.
So there is no point calling sprintf/sysfs_emit and then returning
an error.

David

>  	}
>  
> -	return sprintf(buf, "%d\n", autocalibration);
> +	return sysfs_emit(buf, "%d\n", autocalibration);
>  }
>  
>  static DEVICE_ATTR_RW(autocalibration);
> @@ -490,14 +490,14 @@ static ssize_t oscillator_show(struct device *dev,
>  
>  	if (rc_mode < 0) {
>  		dev_err(dev, "Failed to read RTC oscillator selection\n");
> -		sprintf(buf, "\n");
> +		sysfs_emit(buf, "\n");
>  		return rc_mode;
>  	}
>  
>  	if (rc_mode)
> -		return sprintf(buf, "rc\n");
> +		return sysfs_emit(buf, "rc\n");
>  	else
> -		return sprintf(buf, "xtal\n");
> +		return sysfs_emit(buf, "xtal\n");
>  }
>  
>  static DEVICE_ATTR_RW(oscillator);

