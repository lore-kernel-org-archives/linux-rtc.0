Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA564137BE;
	Fri, 24 Jul 2026 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885058; cv=none; b=I098m2/My6db1gaUHxWwPLSNW9VzC4p7X33gumAP+vVXVEODkM9VteLEhJmrc0CDHl8cGuoZRCWvQGhfKO1NHz6Z0UKNXfcJRC4GbP9MLzlmxy0K4FxJrRc5pdx9abgkKht7MASKEb85hC5ExtNMu5h8FT/OTbwLIKVfNKmAjdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885058; c=relaxed/simple;
	bh=LKx5FH27itcbCovnJXi60HgVWo/3wU6Z9i0JMgSxiwM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R+1kpMuf8HdTHylTY8EIkF6R2LZDybR4s3Xa445HRdJ1cWyXSj8pLT89JuxlPHockJSFLqBFdjBjMTo57xcmDpcUQyWONkbtU4zJs+XxhM/LGyqsLL3uLjF59s85ricJp9DkqnsyEyCOk7FZCZXNDCzJkaA9rNBcG2YcBqHYDx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDLO1kqC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDLO1kqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E5D1F00A3A;
	Fri, 24 Jul 2026 09:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784885049;
	bh=LKx5FH27itcbCovnJXi60HgVWo/3wU6Z9i0JMgSxiwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NDLO1kqCYOTTNLX5enKnuEFXs7EoVq3nxaowJtespr9xq884xaeuwISTvJGAicGip
	 cXC7GRrwpANuVpUIlWbSdQJnfylUS3oyiHkp2jvdSyF2Of7ZtXhVYfY+We/e+uG7QA
	 m6FMONWTzTD/t0ffdh11zyI+HuaxgoeJVB56YeO7IdrOIlJawedOiXrhe7X4XfybXl
	 govpUoV1ASYfvhUGIjoG1d4yKI9b7IMC9A6cz0vKmpjzVthWCLdBa/aYj7LtFm+zre
	 PblTBcs168OtZqdd1b9lrNTviXCnMFU4wy/tCkJa3F3Ovz3UBbklRkC587G94g+W46
	 jloZhKKfK6ahA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] ARM: dts: ti: am335x-shc: Remove unused ti,no-init
 property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bhargav Joshi" <j.bhargav.u@gmail.com>
Cc: devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260724-ti-omap-rtc-v1-2-ffef78853cd6@gmail.com>
References: <20260724-ti-omap-rtc-v1-0-ffef78853cd6@gmail.com>
 <20260724-ti-omap-rtc-v1-2-ffef78853cd6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 09:24:08 +0000
Message-Id: <20260724092408.E1E5D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The 'ti,no-init' property is a legacy, undocumented boolean property
> that is entirely unhandled by the rtc-omap driver.
> Remove this unnecessary property from dts.
>=20
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-ti-omap-rt=
c-v1-0-ffef78853cd6@gmail.com?part=3D2

