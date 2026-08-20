Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA1E395D98
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251433; cv=pass; b=OpWh4Q5ANHJmLxpZGJtX9tHaSLqqcuXqAIWpKAMhGpdoNhxi2Se+MCiKExz1Jgf8OXYjnQ4haYTxhTdmo76l8bjp/dEHPIQDfdZYiQ2MG6psr0Pyd9jZ6aTlQqFhtxuf2JhB1eaVdwSEqiEdGoR5scT7U9hjptYAyglCYPgYV60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251433; c=relaxed/simple;
	bh=Eokv7VYq8/Jopa4y9Fd2HUxgAgf/fH9R5m6fsZbPKyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRjL8lfhUGtik/HgARgI//eepJgipnMxJdF0S21usaHkZ9y0SZo+TmJbnWY+SDPFUK52bMkpYrGv0pfqUNTKXWR0SW1GioaSCtCgMU6NKc98ZQd0H9GMBRmy9WlEHjFGLZ3WCyUdNz+G7PI4eefVc0stfeyC2AAtg9AM/L1gIZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+J7AceN; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+J7AceN"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so1241875e9.3
        for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 11:43:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787251431; cv=none;
        d=google.com; s=arc-20260327;
        b=mXqbeYL9ufnhNM8xC+MJ+4W+Zbvgx+yVKeUhoMjn+Cpxg48A8i63bEjc2hIzsHXGvS
         V738+eOrghDZuFExnxmtv5CDN5wItFYfpr/MxbQpzAsZvYRnFzGfypdNVQ8u0YefB7tr
         D6EQ3/MfPW72mxC40iHPGD8FN/OGc+UXrgJzANC7eRXc3vzAGWel2rvHXhxxMDFkFQfN
         rbaKh/vodQ63hUyQnkEQn777/dQf3VTW41A/aNiS6A6tBUbCen2aNseWF/pu/veNj16b
         9VF/IyO5C7nedCGxduYjnLXfVOKJW+aEMa5qkdy3s39oDZCZuim2ZPs7MuU8xtZULTQO
         0kGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Eokv7VYq8/Jopa4y9Fd2HUxgAgf/fH9R5m6fsZbPKyc=;
        fh=HMnnO3ppQq5iKt6hY+vb+UIWuQGWHLqgoHYFREqUXjQ=;
        b=m7WMFhQ7DlLx0pHof1Ac9lYa3yv9rcib+93oGTBr5EQwhP08tCN88PlUW//xE3NND6
         mIRCx6JrwtAHRtNiLW2fAYX3NZe+bwNDTeLK5ZMc9KeZSlz0MNU+Lk1ZeHGRlWKRuoPA
         JTg9v+U5y3w11eM/wnfcINlYUPNqWVARLGhA2g6/lt0haAJ+0eBEC5lFJbikUybVN+B/
         BtntmQ3+y0QKM57PXKvxN+EyWc2R8YOgJL3WUecpacKRlAMzklYHWcQMn5C7AqAMywk3
         Pcwci7nAqFfcuTmvOZpG11Ks7M7SkxT5NMzcuBUJCqvP0KEIm1xHfBprlAqU6pZiRNHB
         VQ8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787251431; x=1787856231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Eokv7VYq8/Jopa4y9Fd2HUxgAgf/fH9R5m6fsZbPKyc=;
        b=B+J7AceNkzws9Yzpkwgs/1dkp8WLCkWcjQHf29DQ4DRwZ19/Iom7EAJ63CHdF3L8Iy
         KwmAmLk0MsRACu5M76phR5aj0rI1bENI8rD9kq1LPYnUE8j6awVNCozgl8l6u+qWlI78
         CY3ezs5xGw/fXwfIUT8pxM9WLwWqzVAiIroxMfgO6qcGP64MJYqhry4lbm7stwOt0uAh
         GiW1H7Wy4brNpC05//syH4SYa1OSMcLKKVD1bqctSI3nNifAeFWazVIYnW/1eEiDGNL1
         km2B7QGFuzSPmpYg6LRVwycmpAXQ9LZNe7WZsOS/CG6yjBat8QMu1VkLn8n9T9NB01tF
         SPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787251431; x=1787856231;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eokv7VYq8/Jopa4y9Fd2HUxgAgf/fH9R5m6fsZbPKyc=;
        b=DEuGP7C5SGWLHQDPDiphPID3Ab1Ki7sWhJ4UUzlZjX8IaoFf0+vGf1vT7xYrbw2ivb
         DTeZQ9nqH8LxpiBAl7ulChjN4/yqtpXV6j5WDFYreiDxqqjgax0mLShC2UqzNW7FnL7O
         UyFO2YpWO7KNs3H+LzGSiplnOO+0Sy/QGT+XIkfyLJSicJMF8JAN0mOiA+c/8zgmexmd
         FcxpxBTEFSY2oKsPZ7xfD6BV4NySaGO06X5ZxLwmMX3e36SnSaknXPw9OWTkS6B9w2ns
         +h5susAMOiMWKkbN9eloNgWXX6Np2PgvHsxWmoXYpZlle4DzeHCswg3my9mDOgqSjkJS
         Nd5A==
X-Forwarded-Encrypted: i=1; AHgh+RqbEglCnCoTOFoiEtzWS0BU0QXz6laZj830TG23nqgROQ2ddM3pLaHbijTUnyecsNJXMMl8C9RGstI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRRWVv+2729T6mzdVEwZ0cmaM8t+jGiSN68chcewk2YWHelpZx
	nisziujV4Jj5K15Q6FuERgXg6yVYQySgb4Db9YQXrG0d2ERjvaafyD7ZKxbDEhIGz4SDur/bi/U
	FJqYpjUHWjGVYYp+B1lcexQYtDm+YMSw=
X-Gm-Gg: AR+sD11qEV7weZw+lIF0SpXV5j+v2b/K9PsiL+pp0n3ZoNEHEj9X1c1tPmreYUG/wth
	FR9Poy2ZXcZC2BplnwGuC0ZRv3bU48nMnKW6IyGqrX5BTk6HQJnmtHwyY0/g29h7lYUnVONoNBF
	/j6n3MBNCTOdwwbfFoKDdL3yGFmaqHKjn2m5fUYgqAD+idQGtSGRXC7Ix9UYqmIcnbwCNSVPUKY
	a2bfpu2wiS/4x3PvvEdjlyrgemuoyslXBcyQX6TL5kFGfWD5fsUIJL10bzksLb1XrDst+Im1Ifh
	6cvKUcaeu3E9IlG9OFrIvaQVeXv5lkfQqba7ueDonzJezqabgJrew7AIHFAMV1ArrITUNDJgDvu
	DAnIgnKVoEq5hmjFbz5XWhmBGQ6vRvw==
X-Received: by 2002:a05:600c:8b70:b0:499:593b:a15b with SMTP id
 5b1f17b1804b1-499b82f4a2dmr21862895e9.1.1787251430709; Thu, 20 Aug 2026
 11:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819105139.4AB9F1F000E9@smtp.kernel.org> <aoWqqoOpIukOZBFo@shikoro>
In-Reply-To: <aoWqqoOpIukOZBFo@shikoro>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 20 Aug 2026 19:43:24 +0100
X-Gm-Features: AcwNN1V5YPd0FACE_Z1Y0Z80YTfEbDGtlA7AnJxcCLtu81DRXLIHN4JWJGjLB_c
Message-ID: <CA+V-a8sTK-6Tw36XN1NboyPx9RbP38x_7DrMUL6DiCqi6GxXqg@mail.gmail.com>
Subject: Re: [PATCH v4 08/15] rtc: rzn1: Use pm_runtime_put_sync() in rzn1_rtc_disable_hardware()
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: sashiko-reviews@lists.linux.dev, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Wed, Aug 19, 2026 at 2:07=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > [Severity: Medium]
> > This is a pre-existing issue, but while reviewing this file I noticed a
> > potential race condition in rzn1_rtc_set_alarm() that could lead to
> > spurious hardware interrupts and lockless torn reads of rtc->tm_alarm.
>
> Same issue as before? Just disable the irq before updating the regs?
>
Ack.

Cheers,
Prabhakar
