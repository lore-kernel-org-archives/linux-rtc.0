Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C0625B0A2
	for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784964538; cv=none; b=eIPERZ5aYwdLfraAlS26n/4ouXwL1kSXr/pHX8xJEOeJcke1eHbtpKQCXVVRH9ci4f/J1Dk/XXnqcg5YuE3en1JZytTMQ2i28M6zH5nECp9JGwzjxXxEwKWUZ44E+hloLdxipinR6p2mEoPRyjJ1Y1o5BOkw7Q6tj4S5yKbu2fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784964538; c=relaxed/simple;
	bh=kYoxpbSS4R66jnuWc+g54U2haFzkxEUdb++YJbPZ0mI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C4u5uAdNM+vUFFqV2solbca+Isri4q+V6EveuFUWZPNrEydu6M7GTb/ONbmWFClNFHOhPF+q0583qWChcnIJPjgK151hIJg9yeXsYQPeT9skSOX3DuLLAzTIkiV/j9qx/qk83hgtXASZQebK0wXFzkIc756udKNhcCUKeAHNACU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNEYRCYq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNEYRCYq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3861F000E9;
	Sat, 25 Jul 2026 07:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784964537;
	bh=kYoxpbSS4R66jnuWc+g54U2haFzkxEUdb++YJbPZ0mI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LNEYRCYq+ZcyNSBJd5RPJrr28wYf4PhyKVdUe/xpanTQWDoZA7yI6FOXzAg+2poCf
	 HhxpfJs5s7oe3YJUVMS3DrAzjMIp1N08UOodFO/qWI+D38DO59QBF68ZWMl1tayzC5
	 o/v94HNP6Pg0FH8KgWHDEM5X/v+sGdCoc8xnIJIofuuYgxqLWqn5poyk7ajrkqeqfK
	 dzzdv+YljrW4PChDRdavPfPiznv6MU2oknDQ2WleKy2ERb4vre+pChc7JiCen2LAM3
	 BztznMx76JVSpmmVfSfKza7NHWT0pw5RTLJb95Re8Rc5T1EIb32blRRS0DQ3lrWyOs
	 P6VZN7FQTHSsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 29/36] rtc: pcf2127: remove conditional return with no
 effect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sang-Heon Jeon" <ekffu200098@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260723184538.3888637-30-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-30-ekffu200098@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 07:28:56 +0000
Message-Id: <20260725072856.CB3861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
>=20
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
>=20
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723184538.3888=
637-1-ekffu200098@gmail.com?part=3D29

