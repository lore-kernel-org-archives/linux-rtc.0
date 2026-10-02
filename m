Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8E471414;
	Fri,  2 Oct 2026 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932398; cv=none; b=dmKbpnI2unS0VbeFjmEH9YPklGEMy0DpscrRoLXnk/9LecwORV5XqqYT6+IM6R96O1W5CWMac00MZsMnrS/ekhZXzWFH99bCBmtmrnhW2G5+UDzsbxPoQxAZVC9uZI3bP9TK2oKfcc5R55DI2GFcFw3UdFeXQz7bPvszet1ws88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932398; c=relaxed/simple;
	bh=4Z8loIwsiUnsfscZdc7h8ZgNmRdjAEVfnSzsBuK5U3Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sVXdQYYZYh8WaH1eLy22WkHqFCdjgvUJDHFe8m+FTgGSPpybbMsLLsqqLjFLB+Q7n/u5arc/5qSQDEgmV44OloWDwGqq+iMRllLdIMi89lNLXlM3rtfcECuvMPB74H1UEyvWRCQ/It8RDh4sOSBrKonUZ24mg+DjiEVXbRf4omY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSnFHkEe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSnFHkEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA7E1F0089C;
	Fri,  2 Oct 2026 09:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932396;
	bh=4Z8loIwsiUnsfscZdc7h8ZgNmRdjAEVfnSzsBuK5U3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LSnFHkEegzA3wjot8/jDHlZAveEAWR0Ws2Wr91+8s8bLdS09eJxCrPmxE+e/c0aHX
	 Sic4YPOsbhFC/sUvpn8BTUxFdoNp+jT/9wyi+ro+AZKMUGo3m4UmsnxooF7Uein2Nb
	 n1gHoJ91sMgqcmUNA4tw/HuyY9FQ3QH/1RVGjoIzPZFF5ghVwBHRFeU/0377OkooZY
	 7Lxp0Q2hTfgwC98apjtrrdOlKPpvsIaVmu3KUVFgLaQiZugeQI0E944+dkcgKrYM5I
	 kz6/UMASZyaLPEh8mMwj6QrgissZVaT2FRXSPS31nb/A3yuZhAhqIlvVLYcAtO4Zv+
	 i32SXpLLakHCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/3] dt-bindings: rtc: Add missing type to
 trickle-voltage-millivolt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: linux-rtc@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261001193703.734323-2-sander.speetjens@gmail.com>
References: <20261001193703.734323-1-sander.speetjens@gmail.com>
 <20261001193703.734323-2-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:15 +0000
Message-Id: <20261002091316.1BA7E1F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The property uses a non-standard unit suffix (-millivolt) that is not
> recognised by the schema tools, so the type is not inferred. Add an
> explicit uint32 reference.
>=20
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001193703.7343=
23-1-sander.speetjens@gmail.com?part=3D1

