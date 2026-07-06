Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A743BB9F5;
	Mon,  6 Jul 2026 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360717; cv=none; b=XiLV5k8ycN16BuguisHT1URei0PvRrVSb3q6593J2xLmkLHF7qKX/aCpAbFzd/lMBrbseB5g+r5xSnesVm7zwn8UQJCYNZ1xqyu8sXEhpGiMFJY3nbPJjXk0XECDKtr5PFV/m4hC2c3+kzR/owqKhAhEhl32j43SycAZgs7qDbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360717; c=relaxed/simple;
	bh=1WyytX9D8i6JUdert76cbKCAVSM4Y7e5rCdsuo2W5GY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KPbVWsLoKojMPiFGcQvwjeobIIvwCdpxJz50H283AL6ugfLM7g71rqi7rHNgI9G57qegDQvF0Im8osGM70W9zf/BVpzpvx3ZQG31hNoQoJ3vZ/6OFbu4njDKYwKheSYBt91oU9MBlLyRiEGPFBaQZxGKCsAHycjWfYnu8QxnFpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhTuzuGe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhTuzuGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C34C1F000E9;
	Mon,  6 Jul 2026 17:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783360715;
	bh=1WyytX9D8i6JUdert76cbKCAVSM4Y7e5rCdsuo2W5GY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WhTuzuGez+Rm5Y/oulRkeHJA3M4MXbltR3eghBK3F60CCNPOB8Z/2HjwqDbXeibzb
	 C7u33qWXU0Bo8cUAVP5zFfJmCUchW0KlNAkO5czGcm4EzP50viCJ/1O8EyJFKWoSKO
	 NWK6qQGE4QEOkX+m6ewlkAVrep91bpjZD9u4vevrhcm3soR4IqXhoFJK11P7xRNd5i
	 3McB0QcmsvXGNVsMr8ZwZn6vPNJ3R4JrQPPc1kvcP90w/obsU9lgIJN9btjCoIrdAy
	 GUZg8Uip/KhtqAd0iCl5qifnnTcEbIed1P4JmUSV2T6mctfNXjvDGa7YjGnmeSPXa9
	 ffQi/BOq6ohgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/12] rtc: rzn1: Replace remove callback with
 devm_add_action_or_reset()
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org
In-Reply-To: <20260706175138.12587-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 17:58:35 +0000
Message-Id: <20260706175835.7C34C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Simplify the driver teardown by registering a managed cleanup action with
> devm_add_action_or_reset(). This eliminates the explicit probe error path
> and allows the .remove() callback to be dropped.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706175138.1258=
7-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D7

