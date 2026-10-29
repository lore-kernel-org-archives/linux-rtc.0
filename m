Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281140;
	b=iMlJ/ApLT8FHOPQik/5/sT6wdgSnOe6+y9QH1+EM3VFiNyauoFNrGJSJxPnZMGQ9pH9w
	 YGPrEtEk9GZHOYl4KxQ2F59h0nfNa6W9FrRx1tEqedzYHmiRXHLCtqgAT89tJss3CC84U
	 r+8vImNt+vtEYI8jkwFCROEVX6I+DBW9LeFYAxOcriRGyePWWYiDvHIECMbP7knWHATKZ
	 EvIgd3FrlGUOUwWQ9sIpfh6zwNi9MgB3DtoPeWaf1VnBNMmJi/iwLynkz7xRNYsTnUES1
	 fOFLE8sFPTzS54MDgA7WJk6MmoQUMLg7rIxVtvYDntE+Fcna2iaklU47Rp280EycVxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281140;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Wwa+seThtd/BOT0nAnAMzon8zJ3TLX8WdXoCP7ceQT0=;
	b=sAPnVNCm3KsFTvixSr7MifW8AqPBRTmhIxgtmwa3Rc0IWuJMdgJJwey/vAJlS6jvWdn1
	 7Cr3EtsdtRWEBC/O2nghaDs2TDHP/kkn7vSChFwlg+mBpH3WnHbbSz64yZNUjxpYMpwF+
	 7liGyXq4Eo1qQiCsjX5eZvUlTtDuAeaDI9azDwNGaaknu0i/pipHGtMyX2Q7eK3zjXBJf
	 IR5MnZjJHqFwqtx8UPozXj+RfBezbNPz1aSKBvSv9gZdBYnQgf/VtX+rhkiARvizqcVGk
	 Rg19opwg1pfNIMvb4ZAL6sFw3rqxSAEUV/osiozqBClseBVBp903NxHRkEYOhkHKbBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2YQ5V4E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96960606A31C
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2YQ5V4E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3F91F01240;
	Thu, 29 Oct 2026 13:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793281140;
	bh=Wwa+seThtd/BOT0nAnAMzon8zJ3TLX8WdXoCP7ceQT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T2YQ5V4EUaWLsf4Y9QNSchnn7yC9M0TVU9Q0CzUveq7uAkJW2ptoK+Kr+9VIsmDnP
	 sMEAN90dO77C2eLVDEU0HxnETWvsE0ppgAA+EZvZMuhR6+gmE4uM8TJalg7mwLDCVY
	 cY+IAs80W698ss3Di2SKFYVwXpXQx7o8Tq7WuAxd069ve/LncdkSOAwPzI0TJ5xuIa
	 ppRaKLHhOnRDSc96UwQvOYqpfe/bdfb8d8vd6iEHAPdPr+ylVpwqnF9hRasX6FHF9o
	 vTJryQOtHPFeiD04aO5p6D+4mJSNCwkMMqYbqmvJD1FOUl0j2nvt/HK2jtN7yYO6Hd
	 w6Zo/val8oazA==
Message-ID: <sashiko-outbox-189404@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/12] rtc: rv3029: use sysfs_emit() instead of
 sprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
References: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:38:59 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Use sysfs_emit() instead of sprintf() in sysfs show callbacks
> (rv3029_hwmon_show_temp and rv3029_hwmon_show_update_interval) to
> conform to the recommended sysfs attribute formatting guidelines in
> Documentation/filesystems/sysfs.rst.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029132339.9250=
21-1-alexandre.belloni@bootlin.com?part=3D1

