Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BF7442100;
	Mon,  6 Jul 2026 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333124; cv=none; b=AhJWaZKh8+gUGsoMKY8ThlGasj/2YXlSsFgF4jjCLeDg1oLUQHMtEK8A01PYnz2oJVbAAr7y88vZxynekSC9a0mO6lsPbli3y2qGz2iQUqY5xBZ7jot8wfnDL8c2dr3PtVaCn/FAElWLo8W4Vvfxvs6BBHg5gxGCEaZhnc/rZUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333124; c=relaxed/simple;
	bh=ovjf0E2H+AVCLoc9biZ2QE1G8FWwyCQtM/XxFNucD1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tGdYcb6nS9miPqHx4s2j3M2ydricHBIVGK9z2FxIAhZe74/be4bI9n2DJRJ+fveo4tsnJjmipY6bMhMDKJBRgeSrGVLnY4yVYKnkM4z99NBZh/s8BCnOI20Zq6mfficLjKuYJ+b+1A2hvCsGKdgG5tyKIVV5vdeVe+44rB8Rl2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYJutTeP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYJutTeP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8C01F00A3E;
	Mon,  6 Jul 2026 10:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783333122;
	bh=ovjf0E2H+AVCLoc9biZ2QE1G8FWwyCQtM/XxFNucD1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WYJutTePeshrkCno2T4iVDRQborFw5vqWHXBirX+lRUzzPuqKbFhNEFImsPS1ql/0
	 BlKArpBLdiMSQOD2n8AGWsfxYUo5+BEHWpoupwdOZF4CIu3Qb0hOPWaw50hgQ1289g
	 9YDEl1IFb0P1sEirwkCjFWiQOb83sxAKD/qrai2QOhQwNvG+GeetRlR4lYmyEBXY8F
	 3Du8aszLYTtlD86wR1otTTbe5xkXhp9Irh5B+pbS1C/3NYbfzPpJUtCOO0Iv6awSDr
	 fqIZ0oUsv2buIQ/6RWFNHiflxLCTFxlrLnXDCXQpK0aEpsHwLXbxDzNZ3z00Qg7/IJ
	 DupCKOuLu1y1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/9] clk: sunxi-ng: sun6i-rtc: split main oscillator
 div and gate.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: conor+dt@kernel.org, robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org
In-Reply-To: <20260706-a733-rtc-v4-8-f330728db3d3@baylibre.com>
References: <20260706-a733-rtc-v4-0-f330728db3d3@baylibre.com>
 <20260706-a733-rtc-v4-8-f330728db3d3@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:18:40 +0000
Message-Id: <20260706101842.2C8C01F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> On the a733 the "osc24M-32k" clock has the same gate bits as the previous=
ly
> supported SoC but a different divider implementation.
>=20
> Instead of a fixed 750 divider, the divider is selected based on the
> rate of the oscillator. It can be seen as a simple read-only divider.
>=20
> To easily replace the divider part depending the SoC, split the divider
> and gate into two separate clock entities.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-a733-rtc-v=
4-0-f330728db3d3@baylibre.com?part=3D8

