Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C94436BC9;
	Thu, 17 Sep 2026 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671688; cv=none; b=Zwlcl6jw9cLBDuWNQqCpdT4nbtK2iLDZBT/lkf/Qmk+aVy8kFJjCl073JJTtbYBpBUCfHn83pWTZLhFoMqZ7WXLI3EnddFHzF40p3InbAl73gGvU+81fFkbbyNsz24vysfCj57NfaIadCrDilyvVrbErOgdpiglUUk9KA9BpwY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671688; c=relaxed/simple;
	bh=H6MZIyQvTZ7W3AvR4QtO8tHVzB+A6/nzFs3VZmT4k/U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vl131h9kEe544SonDsLdUH6JZkSHczqKrbRm1n4gAlaEbU+QVgW0Ccwkc7gkvRmHD5Ggy+ueM8FVFb5TGUVm+rv2dR2/DtWvSv4js7z5TWXluznKmfcB78Gd16rjTMD3T1VpLk91luJwHIlzLjpiyI3ZdZtaboXStivtPSazyco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GL+Z9/sR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GL+Z9/sR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC25B1F000FF;
	Thu, 17 Sep 2026 19:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789671684;
	bh=H6MZIyQvTZ7W3AvR4QtO8tHVzB+A6/nzFs3VZmT4k/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GL+Z9/sRGuoalHoZPnKJE0mKdgFqdqoppHTELJt0xFmFakq5PwDBJxJ8QcKjKh2H7
	 uqjB/83AwymW0GD9oFuBTetbS7BV01fnqIDneouTT6FHw40VFjCYqVoRZqw51x/PzU
	 4f/FCeWCvE3/heQYyNfOi+Aa4ROug9DnV9A12Wr/vNF+YOcWxt2LlDHiVB0nChMtBy
	 2OM0MnLmc619PaV1XXDrfHVJ/w84eOevAlaCKNFLw5YKJJJS69WmaPcxdlY/ZZOeqv
	 Qog28CSk4v+jdaKngAsHzLk8Y6sgtGjImn6aO0QehRsgtKZFqP0C3enWPtw72PkYeu
	 GiEbt4PF3HwBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: rtc: rzn1: drop unneeded
 'start-year' from example
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org
In-Reply-To: <20260917185903.61253-7-wsa+renesas@sang-engineering.com>
References: <20260917185903.61253-6-wsa+renesas@sang-engineering.com>
 <20260917185903.61253-7-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 19:01:23 +0000
Message-Id: <20260917190123.EC25B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> We don't use 'start-year' in upstream DTs because the driver does the
> right thing by default, ranging from 2000 to 2099. So, drop it from the
> example, too.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917185903.6125=
3-6-wsa+renesas@sang-engineering.com?part=3D1

