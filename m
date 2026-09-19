Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C342AF1D
	for <linux-rtc@vger.kernel.org>; Sat, 19 Sep 2026 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776658; cv=none; b=bYDeAGzX/wq6DLCGwS/oqSqHZP2pp/G/9ls/60pj5vkkeQTZKw+3UROPjt7zFwHeiv3pOHzKrpKvu0Rl+eU/4oNdBFyG7vn+Pjpw46FGrdLoJXap9L9p4aG0hTuNXigJn2mvFKc+2gz3wi+1H4wCt0BdmV9yQM2HaE5gzi3+opA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776658; c=relaxed/simple;
	bh=3u6LxnO8S1L+FvP8ydBlMoQhfmEUwHNhq1NQs26uljQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjuaHhO9t9sK+TArmANT9MYDjbkdLaazAHzDanoYhtgFLqTQnLUbV8MW2GDpr+dytnOCEO9U+B8mwZ8DinN6Kq5Xc3eFY46d7qFixyd8bW6OZDG85/9Ydoklxi4lbhr6eTLfpDA3im7jrH25asjxDNCqo/6SRHpXMnbRy4aDdrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhUJvGl3; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhUJvGl3"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so9312225e9.3
        for <linux-rtc@vger.kernel.org>; Fri, 18 Sep 2026 17:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789776654; x=1790381454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F16K27rFvLVNRx6pCd8p7G2zjKaT/cQ+4xi5Y5Qi7FA=;
        b=hhUJvGl3ySjIreu1dRRysMpHDGN2n3QJLRYjWQr5AKLuF6dwZrCKOwCkQaXYMizSo4
         otV93zsuL04yqkVAmi49//F4KapECyL4WPSKc7cyd6fYHWoQCwNIe6y8oW+ysTycr0Wg
         JATxVeKQnnEqbK6hRTT6ga6QvmGfStmcFF4ZuyIP5THbixgBcrO/kO2sq6R+nKS3GCpF
         kmUiP6O3LQ5ZM4tT9x0FlorDehx9n/67rg2uB1zKaNGj+SGQ3STTRWPO6NaOlK+mMFmu
         9I5m/poIgsqP2x3z7PjocmX213LeHuZAWXO1fOYI7auB1jS4kL5SpFoU53Rf3Dz5ROtj
         GkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789776654; x=1790381454;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F16K27rFvLVNRx6pCd8p7G2zjKaT/cQ+4xi5Y5Qi7FA=;
        b=JoR/MZlGrupeoIfA+seCSPJHV5zGI0FA+fJiEDjEWNmJx6cJkQU+hkiTPm74mRBQX+
         GiEszm9+GyxTczlki+N13j3fKk7Eyhh39j/6qDgn7nx7+fwFCfWFYmGi4xuJnP+WPFjq
         95+qEbIWJBbVPa5C6xxUChSM7dqsnJsYyzvSo8IEm4y5ocN+0TEtNnthXauxytsLxxKq
         ggq1+I0XfEmHm31YXJ9zVrbkB/EwdgSAXcdLdMoH4Q1skoKxxun4RAnh46cwUpc0pmId
         mhoKT7nNUP9EpNDBOos+1NLbXkAkZOPwk2rtZNKvtm6y0180OCqfZgD14ALabirsFb1g
         g5RA==
X-Forwarded-Encrypted: i=1; AKwUvByqXs8D/FybLJUZdOQTzbbqsLZovG1fVojQoRcO4T1W1mj6kdbywt3Q06XM86R8JuyChX+kwsFRrpI=@vger.kernel.org
X-Gm-Message-State: AFuF++mdgMk40PNYIBLW3eLPRWKGBidOBxQ2kkBvlJv+bQG0cMXYeMAZ
	QlhW+w+naSCyuFW+HMw5awmfUpSCUujcrT8xm1MhwEhcx8g9IR4BknXO/3tX6w==
X-Gm-Gg: AYBFou2KOJYevixUu+LL+aA+aJKvKFgiTN5WtdH5ceLKUUVbwcoXo0Mh4UxJyXYIgtc
	KNubtPbapXURnYyHXPHvH1cgahooK61KrwJFK7Op3abXz7O2wfLxEsXF5XKj3YGOrRSO12CdC72
	e7OKnHDAY57Y8Rspa9bjeb+sw9p6kz3OJJ+KU3aCCHQgG9zezLPXLxzr5gxnNoEVXWGi4Y1Fya2
	L3k9xpeYUltKmxtJLc2oPbBi75f72IzFQuy/SIFEHM9G6GeFs/y77IUySkaXuZygyAA8VT+7kG6
	fiMnLz4/dBKW0oRXdWS3JXomlqSCzePGq/19Pux0i5V0OppybYUfmOMQI1LomKvGnHbF2BUP5OW
	DD18UCqk25h0nXENBV9PRa+ozpCYXkUopKQHmYXaFRflzhhvEYHvzqB1cbIUUV28ASy0nZdmClG
	u7Gm3LLgyNco48F9DV6WGu58rawbtnd3J6yyC+GW8G4wuFrl9ktJpd5o6y6MVR+6Mwn0ydEZ/5s
	0Zuf7S6NV4hnhsx3c16Y51lJH1Do90h/pvzqN8tLyfF7QO1XQ6TFtNNfX4RdqBnl+2j3cSWJ5lu
	gSkdS5C/krYT1YXEwA9wZry2TBLQXgmRhKraGB5UarHAQdvS0YewPZ6HJBicSZ2u/kLi0r00HzY
	0
X-Received: by 2002:a05:600c:3ba4:b0:49c:fc6c:be15 with SMTP id 5b1f17b1804b1-49fc57414c4mr69034665e9.27.1789776654097;
        Fri, 18 Sep 2026 17:10:54 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-9caf-5101-81a6-ee25-6e95-e1b0.310.pool.telefonica.de. [2a02:3100:9caf:5101:81a6:ee25:6e95:e1b0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0f7b9bsm28519515e9.5.2026.09.18.17.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 17:10:53 -0700 (PDT)
Date: Sat, 19 Sep 2026 02:10:51 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: class: Make the time32 hctosys limit configurable
Message-ID: <aq3R5QnCpu_fOq8g@gmail.com>
References: <20260914212537.1452-1-kmehltretter@gmail.com>
 <7c020979-cf03-4ece-a7d4-b1475d1400c3@app.fastmail.com>
 <aqnHDxRIBncNH6qr@gmail.com>
 <59ba6707-c5d5-4fd8-9200-f910e61d9232@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59ba6707-c5d5-4fd8-9200-f910e61d9232@app.fastmail.com>

On Wed, Sep 16, 2026 at 08:56:02AM +0100, Arnd Bergmann wrote:
> > existing safeguard automatically and prevent restoring it without
> > re-enabling the legacy ABI.
> 
> I'm not following your logic here, what is the safeguard?

I meant the existing RTC cutoff. In my glibc test, accepting the
2040 RTC date changes time32 clock_gettime() from success to
EOVERFLOW.

> With a fixed C library, COMPAT_32BIT_TIME=n should act as a safeguard
> to ensure that no interfaces can be used that limit time to y2038
> and break unexpectedly in the future. The RTC_HCTOSYS interface

Should we try adding an option to build glibc and other libcs without
time32 interfaces? Looking at musl's source, its time32 clock_gettime()
wrapper also calls the time64 implementation and checks whether the
result fits [1].

> actually make it work. Since we have COMPAT_32BIT_TIME as a global
> option already, it makes a lot of sense to actually use it here
> as well.

Could we use COMPAT_32BIT_TIME for the default, but still allow the
limit to be enabled? I could split the update into two patches:

1. Add RTC_HCTOSYS_TIME32_LIMIT with default y, as posted. This keeps
   the existing RTC date acceptance by default.

2. Change the default, keeping the dependency unchanged:

       depends on RTC_HCTOSYS && !64BIT
       default COMPAT_32BIT_TIME

With RTC_HCTOSYS=y on a 32-bit kernel, the default would allow
post-2038 RTC dates when COMPAT_32BIT_TIME=n. Integrators could still
enable the limit without re-enabling legacy syscalls.

I suggest nominating the first patch for stable. Would default
COMPAT_32BIT_TIME also be suitable for stable?

[1] https://git.musl-libc.org/cgit/musl/tree/compat/time32/clock_gettime32.c

Thanks,
Karl
