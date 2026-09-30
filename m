Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90E93AFCED;
	Wed, 30 Sep 2026 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782636; cv=none; b=f/Mkq2H3Fr7Jhfdn5avqiKunlgmDiMzuXUhOCSsLGbiKEmawNc2ZCaLQyaluPX30SxWpOlcK1LyeZ2lKF3o6dMlstXmGw5zfQgQKJHY8icYQST8dImZoY+b4ZVu3PqF67147sQQfDFI2pPGlsF+4c5lRL0wefvNoWDf7Tb5D/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782636; c=relaxed/simple;
	bh=uJ4fqTJKRmEJftPMAD2sHDB2lUczjNm116h9c0GSQgQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WBm/9pnf/OmzvfzgQITVWkMaVTfz35CmoAzTY+lcH9dMq+8+qvHSVNCmmck+a5PdwAgbSeX+qNcYsIY3I4z2M943SxUQarOzG95PmSxiA+y7D6+9rS8v2gdjuxZl0nPj0STD3C1psJz0VS6D4NECr8lC3dPiANTZcD36vMoKspY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZluHc+f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZluHc+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A8C1F00899;
	Wed, 30 Sep 2026 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782625;
	bh=uJ4fqTJKRmEJftPMAD2sHDB2lUczjNm116h9c0GSQgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZZluHc+ful9aAubpIRIddEIeK3tvpUOGHX2InY7jok97HJUSTgffIEXManFZo5qyD
	 ZGsDlhUTsoWkzt+H0NBujsgoHhDLUPiSi7puGD7PBR2myEJBdWMh98eL95MyWjVtCt
	 I8xrODwtGIX/Qj19e4VvxYKlE75Rp1WtRVP88eFdU/voOlwFCaMzTJL5w1w6pq7Ban
	 pi1/xYgN8LypD0vLd+dYfb4eYZ7zTJri7PgN8f3H5bSYtgZv03LBadJuYr13h/Zq8N
	 +/3awrEbhhlLZrdFZ0Ja4MRZmq/k5J8iPHGZHrMnHGuN+wpE3O2J7iyBVHWcU9PPb8
	 CbP4huG/xEWow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/6] rtc: s35390a: Fix alarm not disabling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260930-rtc_s35390a_int1-v10-3-e7b1cbc50a7b@posteo.de>
References: <20260930-rtc_s35390a_int1-v10-0-e7b1cbc50a7b@posteo.de>
 <20260930-rtc_s35390a_int1-v10-3-e7b1cbc50a7b@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:37:04 +0000
Message-Id: <20260930153704.E5A8C1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Implement alarm_irq_enable callback.
>=20
> Fixes: 542dd33a4925 ("drivers/rtc/rtc-s35390a.c: add wakealarm support fo=
r rtc-s35390A rtc chip")
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-rtc_s35390=
a_int1-v10-0-e7b1cbc50a7b@posteo.de?part=3D3

