Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2A36B076;
	Fri, 17 Jul 2026 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303399; cv=none; b=XP7CJOIDqFu9PKOSTZoP9II4I/B8KWqbmE+fJTRaJx6ZWTHyh24JGtxK+eS7+2c0J1HWF81gqbs98Uh4shrFMkwAoSPglvcnlMGiHv79IwWeJX90BPcsjpE3D9g5mUR9Ny8EB2Ypfri8ks6IhAR83XiPhLrQscJkKUykbIIjX6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303399; c=relaxed/simple;
	bh=vX3WfMyxWSXvUI3mOAE3iQuvOlfrJPT+09Ns/uZNcOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ClpLUxt351DZ7WHLzFVifkBiWaaK3lVny7L13mPIQlNrkKvgU9b6CnVJtBpYo6+RKliuWy8cZhbuc7v1ONYyKyRra5rQ6rGVDst7znXbGwKuE92jJFOl9aPuL/VLuW51nzBxiLOxC8DkbqXXcbhp7BCNXZy91cEqdSTt5DbHVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omcIJb8F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omcIJb8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20AB1F000E9;
	Fri, 17 Jul 2026 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784303398;
	bh=vX3WfMyxWSXvUI3mOAE3iQuvOlfrJPT+09Ns/uZNcOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=omcIJb8FvSfv6dDD5ub0smkUHuQyq0cyWPvzJaozh5deSuvndBIsHZlOP70087FC7
	 I/OuIYvCOOKBXu5C3AAqiihf23TCp3M8Qpqgt8s/uXmztADg1KgrNpaVbpzL0mmmvT
	 vxH0I3go0Eudyrp/cFWQi1gIIDl70LdZCCWX1xWgacVTcQFuwKNQk+ivR1Z2wSpaq2
	 jHbxb9lim/ioICgfwH5JFNicond8H22rYYUwfnzxY0MVX7AERlkBDiAJpP/qOSSP5g
	 K6OqyFrkr7TEmMYUCBWYgzgd1EgbuEsdByM6DQ1Xx2gWYpSrY78eQPzPXGIDLshNig
	 /MV1pHZwLeCRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] clk: sunxi-ng: mux: fix determine helper rate
 propagation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-sunxi@lists.linux.dev
In-Reply-To: <20260717-a733-rtc-v5-1-3874cc26abf7@baylibre.com>
References: <20260717-a733-rtc-v5-0-3874cc26abf7@baylibre.com>
 <20260717-a733-rtc-v5-1-3874cc26abf7@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 15:49:57 +0000
Message-Id: <20260717154957.C20AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Applying the pre divider on the parent rate is wrong because, while
> handling rate propagation through determine_rate(), the framework will
> likely round the parent rate again while cycling through the possibilitie=
s,
> throwing away the prediv applied. This means, the parent rate will then
> be wrong when the prediv is unapplied from a parent rate on which it
> was never applied to begin with.
>=20
> The right way to do it is to unapply the prediv from the requested rate,
> which is the wanted rate at the input on the clock element, and pass this
> to framework to do its thing.
>=20
> Change the determine rate mux helper in this way.
>=20
> Fixes: 1c8d7af61b37 ("clk: sunxi-ng: convert from divider_round_rate_pare=
nt() to divider_determine_rate()")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717-a733-rtc-v=
5-0-3874cc26abf7@baylibre.com?part=3D1

