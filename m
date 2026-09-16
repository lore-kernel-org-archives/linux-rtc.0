Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0814AB3A1;
	Wed, 16 Sep 2026 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574662; cv=none; b=rtDA63pJXcxFQNy70v1oY/uPT5CDm/cMyB0gAWLLk+G8pHXC6pS0EtGuMutHPXKE6w0BeFJiEq0qGAba2ggrnPuIvjJV92dHD5/rHDwb2/XyOt+7Z8LfYGuJKSSxKPuJI82Z6rkTy/jmCVNlCrpFyEsswXbj8e2zS8qaFb9URAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574662; c=relaxed/simple;
	bh=78rRWms9Qer+dlDTaNl1lMw2gd6QoS19RlEb+fjPb24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pWMOSkHYt2usNTFuZVUzylk+IfqiiCd9sfbRjS/DYGiRH7vpqDFmMle/wiMtK4+ONxJD8PXz+GSs+zBH+epV1pO76HEgNtbIWBv4muz2UVDuXZ0DwVThCV8Tf15h4IBGB6QMHCUH4iSETaMarnSrLKYnmQK9un85p814bALECQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofrrZhkJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofrrZhkJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685981F000FF;
	Wed, 16 Sep 2026 16:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789574660;
	bh=78rRWms9Qer+dlDTaNl1lMw2gd6QoS19RlEb+fjPb24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ofrrZhkJimZs0oWvlG1jLhGJb1uDz9uA4EPNXDGIQacv2CG0mvAzKuSpiRszEHA0r
	 IEkTraiOlWqdTMgwBQIn9uUw3FpZmpJ4s7q69m0aUWG7adJBld19KurbqNMW/N9Wex
	 kTG34/4c3qvNJIYz9Vc/SXledXdwgu/nW3PYMU+d+ezjAlLJejPiypqAF9hp+z+DeX
	 sq99jehZBAIHwjlSiwJeAntLPYSNpLLDGHaqXdpNxMXWYYbHZApZjg0y39qhnGFKBN
	 1pWageV9Cf4UGXDoIaXAcivbkyZ4qvNWLc8ilRHiAkmN9GLdLOXfI+8TQDU9SER8kK
	 OQg2swFSY6iGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/6] rtc: s35390a: Add missing newline to dev_err
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260916-rtc_s35390a_int1-v9-2-b2567a3e4959@posteo.de>
References: <20260916-rtc_s35390a_int1-v9-0-b2567a3e4959@posteo.de>
 <20260916-rtc_s35390a_int1-v9-2-b2567a3e4959@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:04:19 +0000
Message-Id: <20260916160420.685981F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Fixes: 3bd32722c827d ("rtc: s35390a: improve irq handling")
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-rtc_s35390=
a_int1-v9-0-b2567a3e4959@posteo.de?part=3D2

