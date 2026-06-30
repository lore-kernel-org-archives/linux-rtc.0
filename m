Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589F4330B11
	for <linux-rtc@vger.kernel.org>; Tue, 30 Jun 2026 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839447; cv=none; b=fZBEW+ed7SvaxXMeZxxgRPhCkUTlDCIifvZ/VWFviGUspWPyuadhzFtKqr50NMZP5fpREjceFZ9rg7pVhqCIDWhMiAjtfgw4tAIHiPMJvseMEQc8OlaDf4cnR356kRrTUfSc4AwHrEi6I7gz3MeyVlkXQ6tHUX/GbVQQvwCnuFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839447; c=relaxed/simple;
	bh=0r01x2cmn3hXmYtyDyv4zim79dsmLjtbHrJ0xmLjciE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=A47C0tWXmo9G2/kVvDMqGAPGlCHD2ojBoxrsw/zKLa38Hk95NLoP6I79zt++Dj9U12gGITCcN45k0socSLcwuMUsqn5cJx20fYBHGmb3EYZaPqqfuRlR9oJoHX2ZTx2P0VEgC4fslSxSd/3NDz89nxD1DSAzDVWQ8ZlyLHqKq5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=AxvhOfmx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="AxvhOfmx"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-473dc4cf238so1538586f8f.3
        for <linux-rtc@vger.kernel.org>; Tue, 30 Jun 2026 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782839445; x=1783444245; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57yAsQK8PRPZX/NIX2zY+Ezz9StCeBv5KxRkk7Fp0cw=;
        b=AxvhOfmxSJbgKTbj2w7ipdAxGVG4mYQ7H2zdew2RCnU3NYu8fNtlbHgCWrxBUISdDM
         yam8GcaOHWMLlW8bUGpprY3R06M5eCAIo1b+x6yHGHrEq07DMqJG5NChVUp6NfaC+PHU
         LhqpLyxPK+0iiuE2jG+KNS058iIa1YMcIinjW7HRmyrL3iD326dqRRLaH+kriYGK7mTk
         vxUy6uMDC/MXaStha2jY5x47eTXom726LuroKtXo4voyKFQtYwqIAC3seiKSBxGIYHJh
         51JHZ/Tz/aL21hJ+AM4AuRUfQrKN8BX1/EAeQJYxCIVj8m7AjfzsORyjEhRYnPATz3OZ
         DMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782839445; x=1783444245;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57yAsQK8PRPZX/NIX2zY+Ezz9StCeBv5KxRkk7Fp0cw=;
        b=sCA8Dy6MkUb56CPJbYxAFujw8fPcdcDhslrCTMBwAtNub+GXcQnBB3ZAVW4t7c+Fx2
         ViigrdG7RBIgaeb6ePORywAePyUXhCD5sVFy4VpGTOLolc2dMxNNXc16RZ8jzRGMt8g9
         sIDkfgpFfco20LpKevMorRQUxocbUZLX8O+HGocok+0k8RVYO1rJRdOPZpyxf1qS/Glg
         M2sfS6+C67P8LBJJYvOf3vmewzLcYOBFLAfORAFSoluFzcRXDdwTb8XN7poDUaDzZsrP
         yI2WZnD3uZmld8E3r6y+nuMmco3ooEgoSsXnhmIX62DODe8+sFWXUvGguBhP7C7q6AAP
         imBg==
X-Forwarded-Encrypted: i=1; AHgh+Rpg4Tw4RWYwXPL5+ziqg4erA9KrSbzQRxbpIqrydcHcOwwGwM6nVM7VemCS713Pf6u2vuMV91Q8syM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRbO8BWIdZ/zr6YDDC9KEYg8htwNwm6F3ZrTnIFqEFiBxogEDH
	fHh+3q+Mxw7pnu8+5GCpbjPfkIorN6dj8FhnTQvP3FRk6ITmQa27mpL2SXsoOAHwxqY=
X-Gm-Gg: AfdE7cm3GMgCZABlATZ/dodGEYmM3IsN3KkFf3OKHl5SMm0OdTL3a0O0uMXEK9XjLVT
	Ma01pf748SbzShn85JK+769+uZlxp4qY60lYTuLc8/azzV7+b1y/7TwrKk/F/id8m9TK62IPZQi
	DTWWw8H8PAPwjueDb2B+C0ZABIL9qHvJm3LICCFqeCYICQupss0rFQcyBoHiUPcnq/iDASE1uqY
	EZX7eYf4dsP5Vue6WA1OPn8uZ0xEeaAfbi+lM0m/l5A81D0XSJBgzvxsdIpbKOoXr4VApT5YxTk
	IzVRuXdJdXcbGjVLohPKemSTHfZbWZQdszCt4HAhPawSztzQGrpf8bnd7HDClWvBdWpjCI3TQRc
	t6rPGVyXx6ZdFo6cCvDtXrh3kBoMZk7SedgArC0lYFHbT67IRWbedxOiFrL4tdmji3PwY/YAlE9
	Dy5a/UwGoeTEyYc//JPdhiLXO4iTUXTidnHM6r2JPZ8rcRF6ZMyTGS
X-Received: by 2002:a05:6000:2c07:b0:473:a74d:34d7 with SMTP id ffacd0b85a97d-475505f2c6fmr6427029f8f.2.1782839444699;
        Tue, 30 Jun 2026 10:10:44 -0700 (PDT)
Received: from [192.168.7.218] (88-127-185-231.subs.proxad.net. [88.127.185.231])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47563d195a7sm9017973f8f.7.2026.06.30.10.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/4] rtc: moxart: convert to dev_err_probe()
From: Alexandre Mergnat <amergnat@baylibre.com>
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260528-cleanup-dev-err-probe-rtc-v1-2-29dc9cb6c3f0@microchip.com>
References: <20260528-cleanup-dev-err-probe-rtc-v1-0-29dc9cb6c3f0@microchip.com>
 <20260528-cleanup-dev-err-probe-rtc-v1-2-29dc9cb6c3f0@microchip.com>
Date: Tue, 30 Jun 2026 19:10:30 +0200
Message-Id: <178283943065.3929176.1858325088732682780.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=364; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=0r01x2cmn3hXmYtyDyv4zim79dsmLjtbHrJ0xmLjciE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBqQ/iQdAAJixF0rNdmiUYYMNdbr7A+2m6VmqTmX
 nJ2azfQsU2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCakP4kAAKCRArRkmdfjHU
 ReWTEAC3/WOetnFgxK1lmkkQF+gyBZZLkCYeBzDGc9AvuPib5ECu0DxAEdPGNpDwBv6EXNXTgVz
 sdxCkzV09+iLepfjBpRPYmPeO3t82DTQcJpdxGNFpuh4eQ1gPhy/bXKEj7X75s/QBf1H/an37La
 pXVobrjohzQpShlpPX7GAPwpv3Xkzr7ezS82Uupsf04qFaQAZat0x195WZzc5FuLAfjTPao5Gro
 VBGT9CO0Z5cUW5nmRQqr+sFrQdtwCDLwZRRAfNxpa1tHO732LtnVeVxBq/9/Ogg1V9SP7YUZmtd
 L8SEiY8/eGPSK39lubTpFBmKjonvBX3XzGdJwBvh7fD48zXhmxacOY528J3SWgl24dHKrVcJZqM
 il3ZTi9sByu3kT2PAIkaa8ZmLlYk8PLxaCcEjP0IZZEEMX2KLG1lKkLYn6mu5ENgdZS9Lfhni0R
 ISss1iUFnflR4IUtA7P12PfSD+wqfghK/clZ2Q4RVi++E3nUfjJ4JaF+nLV+N/j7UiKc9I1evJD
 7Z086XjmROyVXTK29I09cBLZgAdLhoLQFjm18xh3Dte2PslQtLymXtQNOV0xkcvb1g1dLcQd63X
 px8+C9MJeDazAtV8scMP6zBI6BJnAXFWuXaKGefMZhfBbKA089CLYGmwllIlyYF1VnZsHN3jlTq
 B5Oui0dfhQqNUFA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

On Thu, 28 May 2026 09:16:45 +0530, Balakrishnan Sambath <balakrishnan.s@microchip.com> wrote:
> Use dev_err_probe() in place of dev_err() and return, which
> communicates the error type and helps debugging hardware issues.
> 
> No functional change.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Alexandre Mergnat <amergnat@baylibre.com>
