Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CBB202F71;
	Tue, 30 Jun 2026 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847725; cv=none; b=LBxvTaE5fy9RZfGv9PfA3tkqlah8NQdfitu2L9lUmmbjRTJHkPacnEpiG1QOkdscHh8/05DZapuS39BJsOWsqp1qX4ZgnYSiBLRjXNMi/sGeJ+vEseFavbACgZDu0Y2qFxEr9bHUbqfHdUE4DwiZZeaHxRXqtMUxZu5MgbLAfgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847725; c=relaxed/simple;
	bh=6vivW5XDH+zbeSdDI3Q94cMlRFbgFu+Ah9jxDnyVH6g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SMwAIN5s01nOX0ozU7hFf/EvUf7HTdykOkWz7PzMl6EQxKFEdbmyRM+0IqZKINufkmsOc5vssHMXzwqwCzPs9AzyI76EBWZAvYoAwcUYqgN0WMQ8Hp1cxBmPYHi//oW2G0W/Y8EyBUaZiWXazg2/nwWrnzSCRFJLeRKWnFgBRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3kByLAh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3kByLAh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29CF1F000E9;
	Tue, 30 Jun 2026 19:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782847724;
	bh=6vivW5XDH+zbeSdDI3Q94cMlRFbgFu+Ah9jxDnyVH6g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V3kByLAhldM2wz9DqQ6RvL5rUxnzYOo1tWRZ01CfGI7uaX1hRodejD62+LUvJVPwD
	 +Dvn27DFvY/PXdvsuAFPzvcpXB5nz5q4HP860hpDV51tD3nkcCLhU7jGAYBZlVdilu
	 4QNZ8gyy/wsiE8l7KXYPqPehk3fN17vHx/2J69YuMfSlqHgDj7GqUlVKLyHHMWIaCt
	 PJt4kr9Y9ezMp7PdByoIdGyrxC4JG3/P74QIDpHhYhJ3m6Y8Jztr/0+AmF12fDPTtl
	 bXdVV/TDbh4ZmKL1mn+2LrkgvZT4175RoCGIyfFFqm5Uj1aUBo4XINjVJCJmvl3ob+
	 TwdKUc+51bCaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] rtc: s35390a: make use of interrupt signal 1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260630-rtc_s35390a_int1-v1-3-1b2239e16be2@posteo.de>
References: <20260630-rtc_s35390a_int1-v1-0-1b2239e16be2@posteo.de>
 <20260630-rtc_s35390a_int1-v1-3-1b2239e16be2@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 19:28:42 +0000
Message-Id: <20260630192843.B29CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> If configured, use output pin for interrupt signal 1 for the wake alarm.
>=20
> Successfully Tested on a Synology DS923+.
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-rtc_s35390=
a_int1-v1-0-1b2239e16be2@posteo.de?part=3D3

