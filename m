Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281187;
	b=KAgUFJpDDQ2DwHjZ69DnSsjCdQws2Z8HhgwOBDqqX79LbUf/AHgjg3yB3ILArMR1b/zS
	 XVFYQ//aRdCU3peMju0/55m4Kkl/FcT09/hju/HwdwvgkVefbzjTCRN8DXau/70kuqOnN
	 x/VK7D9zAtDrW6A6byQfW2HQKZJ0p50EH2RodHK1FbCWH7p7T2TTTVY2r3WiX48A/QZL+
	 NSh5v6D0yP0aYsPOJXt/gIdMI6asgJHo69IMj3esuNsvOYtLEUul0cuODHAd3Raf7T8BY
	 GhhdrBplrpQpzCo1tiPcNf2iBordDT/lG+0/GB7yneq5446MS4XbVjaxiIL+/UvcaQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281187;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K2UmAaMeuhN6+707nqtpB630EUYooX7Od+OviKQ02Nk=;
	b=4lmrgPEshHsIpdxgmMc1MZ3cd2bilXbccNa7hp3xgAjnDO2ftdJYSinqsEm/f1Ti50o0
	 UFhoB+WvPVD8fkjy3ev5ita4J38/okLEJ05GUIAlv6PLbA1PBBtJJe/Gkh+CORRlpODRK
	 xX34j3hBJ1k2jdDCA4wyFO7bf1XQjpjw5uri7cpJoslAlsbjcA2bP5hwF9AWeEd69nHFG
	 GSvE+DB2JpkiMyCFY6NrgWXdyRIBC5I7Fbmi9HCyNzn4oaKoRcYourhNrR+X6kz9fJZkC
	 4wYku6pNFKoRA8E9FVBoWxVJJwybAthfSZjCBffS9AaOdkuyBDJCrj+34D47NbXnnrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T7yOba9q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080DD606A31C
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T7yOba9q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D041F01240;
	Thu, 29 Oct 2026 13:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793281186;
	bh=K2UmAaMeuhN6+707nqtpB630EUYooX7Od+OviKQ02Nk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T7yOba9q81TtCSNn1w6F8SebeXkYigbW+D/Bejcy2jqjeve6aYby8zfsgiM0vDgMQ
	 Ub2jAitKqeXxmTgb6qdNZbhACjmf4/sYM9rTSrGUEoc+FluXh0x5Lpvcz59TGKGL6d
	 dX1s6sHE1HO6AVVGt1CHIQ4w5A/WrjfosiHBgV5/ZdQxIQKV1xeRG51gejYfU5gMW7
	 r3WN0IqVXsbNc7ZZh9wXYeIt353orWwBQUEJQPcRc9S5IwUZ80f+WLUQ6BQzBAwSa8
	 hjoyNNIyRq56iNFJvdBwaHsC7/wG7HMA6lMDnOcF34ErOff5uo83NGhYWKlTM/3jNJ
	 bVAGZM2VYUpjg==
Message-ID: <sashiko-outbox-189407@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] rtc: ds1307: use sysfs_emit() instead of
 sprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261029132339.925021-11-alexandre.belloni@bootlin.com>
References: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
 <20261029132339.925021-11-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:39:46 +0000
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
> Use sysfs_emit() instead of sprintf() in the sysfs show callback
> (ds3231_hwmon_show_temp) to conform to the recommended sysfs attribute
> formatting guidelines in Documentation/filesystems/sysfs.rst.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029132339.9250=
21-1-alexandre.belloni@bootlin.com?part=3D11

