Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935E336F8E6;
	Wed, 30 Sep 2026 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782597; cv=none; b=l5ejeVinmEZtBcTRpVVlr6vqGJyRnaUepc6cwvuj5xsiXU3BgdkCUkr98Q+DIg0iT80wtWl6r47e9xTEeoAw3B80KTuBuIKbgt70sltrDdskENXP9Nu0nhY0fSVdY69f/opvzE8ccALWdbqRtF9FjCINC+DBepsQ+BStjqcXLy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782597; c=relaxed/simple;
	bh=mPjenCCX3SGvwnsOFHqQnVPofnF1APm2ht7hcUnK5As=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QeAB2+9S8U/73Ccwpqfvk4/sPQi0L0jyjPSEaTY4dzD/eVaQej77TS6SGX0PD/MwuCNiMADIYDyUeGS2WEO5QtaV1SG3KiUwDdbigQSCTnZMCJl1DleJmbklJ4KMGHfxFZUbz3YjIcNhy70Rxd6kQsRISVRbWUqhbRsIBfn22og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUN4aWOD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUN4aWOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C091F0089A;
	Wed, 30 Sep 2026 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782584;
	bh=mPjenCCX3SGvwnsOFHqQnVPofnF1APm2ht7hcUnK5As=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TUN4aWODuKD2rfAJOYe3sFR7g2LrvFBXJKcwZesJYpjlpVeJJBs7bwjB8GLRZhoRF
	 PNHdqOt8lmoznv0E2nsRVUfE0o/qx8i2yNfjUd+YKjvBpjaVVUJoA8G2hdGGTpa0US
	 9IEUMrltR9zbk0mGNb572WxQeGiGYQDQurS3ge6exoiKQ2arTI1f49yscHW/Cya4RU
	 vNAkcQAo0BZdfSQjjMDYXQ7rF6Xtv/IYw/ahj6nuka+ZA8ftnHZxrZncsRqe5O6DiQ
	 9zZevfMjLmyw+Zv9t/hCFA85bPkwQFkGAqAUlNnAiU0z+qNdG078CAoBF+qpmYYQS3
	 MxUB6cr1UrF2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/6] rtc: s35390a: Add synology quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org
In-Reply-To: <20260930-rtc_s35390a_int1-v10-6-e7b1cbc50a7b@posteo.de>
References: <20260930-rtc_s35390a_int1-v10-0-e7b1cbc50a7b@posteo.de>
 <20260930-rtc_s35390a_int1-v10-6-e7b1cbc50a7b@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:36:23 +0000
Message-Id: <20260930153624.01C091F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Synology NAS devices use interrupt signal 1 for wakeup alarms. On ACPI
> it is not possible to configure pinctrl.
>=20
> Use interrupt signal 1 for wakeup if no pinmux function has been
> configured in devicetree and dmi sys vendor matches "Synology Inc.".
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-rtc_s35390=
a_int1-v10-0-e7b1cbc50a7b@posteo.de?part=3D6

