Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C368D413799
	for <linux-rtc@vger.kernel.org>; Thu,  3 Sep 2026 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421839; cv=none; b=DRKtmjeqBLnmwo3hzw71cRa3hkrzyZ/2S49uNYQ6T2oD7SVdtsejQLfbxdwk5vkBDcxhInB3Ys1dqLRsunTQpachMnOIuv8xtsDPX+P8nFrPJkSOmleyPQmi+/MnM+l3Ux1cLX+ce6jAVPO7Gz1TqT3SQbTftWLAkZEg0ONjQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421839; c=relaxed/simple;
	bh=L27zXQVW97kdfD4KLhL/CxRoJaFAgZiVH3zRIl5rzIw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mO+SZLZ9+5YZL0ITuo7WAAvpkP9UYsk5ms99aAHehJVwpE4bmDO6MDmnlhhZiBS7t9Rs9luz/MPSudRk18BxXkSFb0YPBsU0piAUOI6eWRcUSnSYNKam4lrN1IatOYIgmi+mfixepVzIZyf4aD02MDamD53tr15JFP23Xl5QeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQ5HRJhT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQ5HRJhT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B721F000E9;
	Thu,  3 Sep 2026 07:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788421837;
	bh=L27zXQVW97kdfD4KLhL/CxRoJaFAgZiVH3zRIl5rzIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HQ5HRJhT60pH+E82MQbjtHJ0CSoaoBKr7HUWNidkSd7FupcZlN4EMQ3AbVGfiOkrl
	 zo/xsX42WLg449FNKH5wEG7yAmLjZfGK3igq+FcF1yH1Oiy1Iljn+JkKyYVBHvlbza
	 OCeGB4M78oju+kfrl1jRntb8w/h6FDKtf8Jlg5935ZZPEpwSb70Omq5zRdsptcpImA
	 pYMHdrdnXVf1ohRu5PqqQBRhcwJMusDuAz/I0vv4UYAYaY/rMAneGbt1GxIe2+e67X
	 Wo3+NcYC7IA8V+wXY76VP7gUBfWClVCuO8eon12+W92/vfobOmb2vpejAss4z7g48a
	 32Ymjxz5RSGAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] time: test: Avoid unnecessary divisions in
 time64_to_tm() test
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWggKFNjaG5laWRlciBFbGVjdHJpYyk=?= <thomas.weissschuh@linutronix.de>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260903-time-time64-to-tm-v1-2-660be972adfc@linutronix.de>
References: <20260903-time-time64-to-tm-v1-0-660be972adfc@linutronix.de>
 <20260903-time-time64-to-tm-v1-2-660be972adfc@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:50:36 +0000
Message-Id: <20260903075037.46B721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The time64_to_tm_test_date_range() test case is slow.
> One big part of this slowness is the division done in the test loop to
> calculate the current day from the current seconds. As each test loop
> advances the time by one day, that division can be avoided.
>=20
> Remove the division and instead increment the 'days' variable directly.
>=20
> This brings the test's runtime from 30 seconds down to 15 seconds in an
> emulated 32-bit ARM machine.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh (Schneider Electric) <thomas.weisssc=
huh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-time-time6=
4-to-tm-v1-0-660be972adfc@linutronix.de?part=3D2

