Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718193BED66
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792322049; cv=none; b=Mp3opixDskb9qNjfqQoMus1AbwMqrkU5wxMoKv8oPfPsMBmDfsJJIffZxJG2C16QS3lBAwaCmR9EdJjJbh2a07lkh9i2qHF3ayKjyS/U5dtFAzjdTn1ZylPwFYrwj9cCjmFlLLmmXGbnfM1DyI0NqSBvEx0EC4/Fh08MXQ+oNjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792322049; c=relaxed/simple;
	bh=fctVlUNxkjbmnVMzce9QkG8geM0AkD1apjhciOP8ows=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sM5+MhD8DrAaua7YJRSnDy1bOyxj0thhyOfAJhJd0tT/7P72gBxCAbRkOarXMoEBhg6OXKbfht5bOg/v4z5mb1/aUrMUbd16hxvZV2+3jIAeOiTK2ko75Vgoh+lgRshaLwK1RTiIC5z0XjyyOpEb/1jn8mG24BlOgQ5j1PudAGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTuWCOxg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTuWCOxg"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1e34ecb02so1679315e9.2
        for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 04:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792322047; x=1792926847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fctVlUNxkjbmnVMzce9QkG8geM0AkD1apjhciOP8ows=;
        b=lTuWCOxgProbE8mHJ9wowS4qKnK6ja/DLvfMZ9jtcqypPq1J8q53ZzbK97XHbnhvgc
         MLitGDvbEYLZzrYheqMuERPaCg/nZ7IAuQuZSz2k3fAyVy98J1bVkGkHu59olvasf4Iv
         DCJpBd3u6maPityrvNKrwXVsEV00AzJaQTtzxhunkFtZb8tVLlycoOFbpKwbB5wclNGj
         yvVqrxGzK3H+N1fhuO11C57XrMHiQVdYBcgQveWj7iHyeiGB7HWAK1BMix2yQkVGtH9s
         fzX3CTsTnSq7lmqpVqwbxBSE/0k5LME6Lv2Cggm0tVskjI5jx3bjgVMLFGwo7R/pHz2X
         ae+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792322047; x=1792926847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fctVlUNxkjbmnVMzce9QkG8geM0AkD1apjhciOP8ows=;
        b=OZJ9L/O0gjdZyuJbeQbXJwR+XC9wxhqf88OGZ60Xie7xuNiDH92C7dkYXbp679KzcS
         WmVnDJCaovrC1GoUj9mX3cnBneG+F+pDZ71MfsuQUSPqVdhw6KJgp4sGHHDsyqczDlp+
         R+dmG44zTXHtS8A3ejU+MXzuwfepGxsD5E2LgZLbkL6GIvIOa2qm2k+zp7pLMMCW0Aqe
         2PxbOwuOZlRCxgBf0ma9XRS7fs30YzENEOBgYogZyB6NkmNmbSNcq2lVzGteCuHA6+DT
         IIoZagwN55wfQhIJxsGcOdJnGe5qwKCaq9TZhqVsymMKmjXdMfYRKKyee+JE5BMZIoxj
         U0ww==
X-Gm-Message-State: AFq9FYIDu2P+rKA4x5xAtOUkxyzX7b4bGXsTfOWMxbeoLWM7W6ztJ2wg
	m5CB67Ca+1AWlodEOGxR7ESTXV+wmv/tCWgYaEHk5zY2SSC9tL3r/aCE
X-Gm-Gg: AYBFou0cYE4pexo39TKEud5uo0H5ZpuYb5wmvJ+PcMd4Tr+1CCiy/TkN6deeNuSwLLd
	HXbfDir4tm+Vbcg5ilQOSQfo7dP+FTZSAXMkecRQxUwHK/4oO0fTLqlpf8QBrntTqA35rLpOugK
	w5FaFTHu6sHuTvM1RMQR6WExMtBGz+ETdxCqahvCBkacBq6Xae1iOojkajoE8XRdFqAPntWWtpY
	S1AfkX4NaiFeLJAoqeWIPFHGGwZe/crw86mGeM8HRiIzoFDA98Qz/YD9qKc7RlVV/s9iL/cDJql
	KBPcY+nHXazoO1+VZ4FCE90FR0kcLPjUSelNhGlnrX+9WRAYFs2nsd5cU0qhjkwGYDpdqYqzqX7
	EIz4fH2bJ+7wrMdTYABFGWnqadbhOwC3/ErYMK9rm1Itz0rNa1oXoMy/r1y/QfaWdR5EBBeUD3d
	m5n6D5fbnBvtkL2G4fBG0Co9Vw5DhCfD6DVTsKu3TYdPta6azrgS8IGRlefBFdOzVFuASvoA==
X-Received: by 2002:a05:600c:4fce:b0:4a0:1b14:e283 with SMTP id 5b1f17b1804b1-4a1d75ac25cmr109797265e9.1.1792322046507;
        Sun, 18 Oct 2026 04:14:06 -0700 (PDT)
Received: from fedora ([94.79.80.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9a88bbsm290127415e9.3.2026.10.18.04.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 04:14:05 -0700 (PDT)
From: =?UTF-8?q?Alperen=20K=C4=B1l=C4=B1=C3=A7?= <sabri.alperen03@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: class: Do not inject sleep time without a suspend snapshot
Date: Sun, 18 Oct 2026 14:13:57 +0300
Message-ID: <20261018111357.164684-1-sabri.alperen03@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261003163138.14221-1-sabri.alperen03@gmail.com>
References: <20261003163138.14221-1-sabri.alperen03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alexandre,

Gentle ping on this patch. It still applies cleanly to v7.3-rc7.

If you would rather see this fixed on the timekeeping side, for example
by having timekeeping_resume() not leave suspend_timing_needed set when
a persistent clock exists, I can send a v2 that way.

Thanks,
Alperen
