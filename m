Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B814266B1;
	Thu,  2 Jul 2026 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980194; cv=none; b=QqO9T9yBaVon9xEIB2Jk7gCi1ozMHrHQHFNF4GT6sspHGHSXtzuH1vtY2NhTY0rd7Up/Lw3vk7A234SK8AuAc1O33b1SKq5VrnyhY4tTHRjmSvImoO3POGlrOT53bl63l34KD/FTWd8LWwSBtnoVLnjC60rD+QGcvI2RV2LjwTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980194; c=relaxed/simple;
	bh=7RLqPFqUr8X+3yE5h/RZrFUReOE26VTtItxlaTYZeuo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pWZ6Ntuqb3cvbpaX598rZm4BI5qWs9igWxzrZ8zCYogcsdr7eS7SQA//vz3jUfZaeN+0wXSBM3F1/YBH/7zv4kqtM+tjCDQb2Elhcm5jDvkwCwPklTUsHuNYPMdLqIeftSkWcfA9KTS4Wl1XJccmIIveTtKRm7CEFSgczDekDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8FhwDJ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8FhwDJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BFC1F000E9;
	Thu,  2 Jul 2026 08:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782980191;
	bh=7RLqPFqUr8X+3yE5h/RZrFUReOE26VTtItxlaTYZeuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d8FhwDJ6fFHYQWObojFGr7khMftbqQ8mIofINvL3buDXzPZ707qfU2jDTDz/0uUEb
	 bHTr74BOwjc0OjYTw5sJ4Q0m9uXg/LQypsh1B0PehAvnT8FIJC92y+ZJ0ZnChf+ANt
	 YWqSEL9FIDAnQ46NhqoFh+UrtcQdYszbioKX+NVMeexoLaicm2ZFtZUFBJWI1iIQTs
	 omnfnC8prgSwmzvdxHFkVMSl2aupUwEHXAr8G8j90ZBHCKxGJmuAlxWCZUGrIqnTyQ
	 h/DGNinyjhworaJW+Go0+M3jBvBXQYrV52kQ+ZyPqJ1ylawqnxoZFfzyJgToTHJL/b
	 ZEIz2Uer2vtPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/8] dt-bindings: rtc: sun6i: add sun60i-a733 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, robh@kernel.org
In-Reply-To: <20260702-a733-rtc-v3-2-eb2580374de6@baylibre.com>
References: <20260702-a733-rtc-v3-0-eb2580374de6@baylibre.com>
 <20260702-a733-rtc-v3-2-eb2580374de6@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 08:16:30 +0000
Message-Id: <20260702081630.A6BFC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Add a new rtc compatible for the sun60i-a733 SoC and new IDs for the
> peripheral oscillator clock gates of this SoC.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-a733-rtc-v=
3-0-eb2580374de6@baylibre.com?part=3D2

