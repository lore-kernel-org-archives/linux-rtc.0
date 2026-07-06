Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A43DC856;
	Mon,  6 Jul 2026 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360404; cv=none; b=q3DH7staYlZ5bv1tiQpxhE2Z/p5Mm1TK4IKUvNrrPLThSvV+j4amS62Loh32wM9TtjW8JKArks9yjC+SmdJNqa1GCghpmUXFNRoGadkjRKYjmWE8u+G9jEJ6ufWvW32/5Tb42eKrobLqt4qEfb2LmpywYzybt90V+n6K3H/agEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360404; c=relaxed/simple;
	bh=R2/XNkHC0S9u5vkvKH07KyPXIpflnXgiYXGfCDd89Ew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a/+8WzQXW/YwEC9UuvJ0x/n/8sFR9SURMqZwZiuVZfZ/8c1RGYl8oaXdDD7TUchihbvOHVHZOlwcX3sH0zuFxRNcJCjy3bwB2r+RXaBp/WPXs+dLGSc8DR73QgammxPjIY2Ftna62vid+pnmWVwN5vWHxbXvmqgoQcsApO5ydhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1p3U5sY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1p3U5sY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2E61F00A3A;
	Mon,  6 Jul 2026 17:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783360402;
	bh=R2/XNkHC0S9u5vkvKH07KyPXIpflnXgiYXGfCDd89Ew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U1p3U5sYNahoewyL9QpVctcSfqCwimXUuMD8XSHnDlvjltpm7bXm17flBW92ps+mw
	 3zoh6FY02m7kAnkIGCp15UFgpqWpASXDd+CQZsmzAItiH4IwqOj5hCsOJeD0j6CBOQ
	 /P2fEkuvI2/xLV8wu8dqcnuhGR98REFKWs4xanyyp7h8D6pu1gYgXsLYIpb7oAiun8
	 KQmBApDuHlWG+INataMYRzt31pY0K2pznP/AeQwTKjilD9krmHBxcEwxl0MThpsXFW
	 fy42adVnHV1k1N97VLRl23vaVc9glSx2WATXYc6UVorKi6EFxl0Rlrl/wUGCZ9RhbO
	 XShjpgFbG+AUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/12] rtc: rzn1: Fix malformed MODULE_AUTHOR string
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260706175138.12587-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 17:53:21 +0000
Message-Id: <20260706175322.7B2E61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Fix a malformed MODULE_AUTHOR macro in the rtc-rzn1 driver where a missing
> closing angle bracket on the second author entry creates an invalid forma=
t.
> Correct it to the standard "Name <email>" format.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706175138.1258=
7-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D4

