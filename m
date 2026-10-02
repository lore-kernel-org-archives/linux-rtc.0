Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBF147141A;
	Fri,  2 Oct 2026 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932400; cv=none; b=JITqJnkMvETrhPhsu6OeSZdBlSRvijqauB1r813WJF+aHYWQzQReUIRHkcC5u6MS8JNfR36AcyleffJezqwYvvx1ZrVzmqQ6H2el8EmptWGKNWqQhrOu5IasXuY7zjxFHAAb9cWh96Lx8WnfQ6GlVjtCrdj8+q5AVJe6SZJodBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932400; c=relaxed/simple;
	bh=xxunHG4uuNTJ7qkzKQdle5w3Wt+F3AUwPXDhqs+43o0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B00RVm4n57g1oq7Ceja+PQ2vf7wBPkrpEqXhs+TX5ZPnvdHctKFO3rKdMGxdU3feWCPWOfWRBG/10tii4ks7HgS8EHWHPPb5ykZEGSQ2+D/ceNczH+2l1Toif0EvTlr89HTRKWCnJOyadGi7PXPWQHPDqC+9X2w/BckwR7awM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5FRus6I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5FRus6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F671F000FF;
	Fri,  2 Oct 2026 09:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932399;
	bh=xxunHG4uuNTJ7qkzKQdle5w3Wt+F3AUwPXDhqs+43o0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f5FRus6ImGCaEhXw4psVZQIxgsgXxS6kFndNOro/dKhEAvoEwylDWLe8cNmSVYIA4
	 CZOeiFcliI2b1rva6+LnfEFcI3b+zJE4m+5qe/WZYHvcIUKwWWQNkSeOyRp4RLmUpY
	 J2I+Aon7gZkQOSx6MzJWw5vXLrx7dmNspruIMisZNR6exv5WpvILxjXuYB6EWQ4GYY
	 FJNu8T81ZN3omwcFWAAcSYAdD1UUSJ5rhPOeHVB2yk31qJkUG4MDWqWMTAMesxGzXD
	 yWoIDWcc2/89dO8Gt2cbDLDPp5WWinDKz3zpeLKMjt9gRD6doPc26pxzQFDg3cu4qM
	 DfKhPYrKtoJwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/3] dt-bindings: rtc: Add property for Raspberry Pi
 5 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261001193703.734323-3-sander.speetjens@gmail.com>
References: <20261001193703.734323-1-sander.speetjens@gmail.com>
 <20261001193703.734323-3-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:18 +0000
Message-Id: <20261002091318.99F671F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The Raspberry Pi 5 has a built-in RTC that can be battery-backed
> via the VBAT pin. When a rechargeable coin cell is used, the
> hardware requires a trickle-charge voltage to keep the battery
> topped up.
>=20
> Expose the trickle-voltage-millivolt DT property so the driver can
> program the correct charge voltage for board specific configurations with
> the attached battery.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001193703.7343=
23-1-sander.speetjens@gmail.com?part=3D2

