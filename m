Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F532DF6E9
	for <linux-rtc@vger.kernel.org>; Tue, 13 Oct 2026 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894618; cv=none; b=qaZ6mhDoQcuhPW4ySs7GXiuu4ZHWV8yH44y1KfNdqRbpLNDi14fkib7wiLyDKuJqse6xKExubmX4Oa1WQCR61ZS79fXYPL4pkbdmDay1gUsLTD5k2Q3lc+SNdEf9lWJWp64iCLaVtqzEG25O7eD8IVecw2qkYBBu7PqAKTrVQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894618; c=relaxed/simple;
	bh=iEpCBlpclJKdM86FsFDCzDHZs6BWtF81i6FWzHU7jBU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LgfPKiureq1spyD4+2cuZUBRkaxJ3wKzNZ9vS8F/2bAF7VC50VLGi/M/uV3ePi+qNNDj9iKzTMpYPpYOtm0P5EeYQkD6BsF+ccmWtjpNVrRQgIkHyAr4v5nywXFZX0U/O7EvIu+9v5JlU+AkkxS+ldZ2TRrFmlArZK0IY3gGMeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciCzU08F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciCzU08F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39DB1F00893;
	Tue, 13 Oct 2026 12:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791894617;
	bh=iEpCBlpclJKdM86FsFDCzDHZs6BWtF81i6FWzHU7jBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ciCzU08FMvogBTZO5ETisr6rkRiB9btyfdQsoaMwzz+LmuwfiRLEjXJlse2Z/Gkf1
	 i1P48t46J3roV/oqpdBQH3vNzE+jnq9LCIE5/TULZes2GEwd+k/IzaCUM6wt1kgkJB
	 4jXlzOGXGWK+LmmfV/A/+bunUyioq0O6m/+EVsKDld1ybzt7psR/saopki69XKEunU
	 gBa2Emkih9wyDRX6PDWcw4SQc2j37QS20dez37RhwY7cfgQLZ6tSCaE25eFRUrZNQq
	 TSn63CpjAPmJET8I+nnKPUe+VSSEr7fICLfYaWj9feoGAjpJTZl/x3cGbjadYspBbq
	 onmc4kqyHv23A==
Message-ID: <sashiko-outbox-169713@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] rtc: ds1685: keep setting PAB until power is
 removed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Imre Kaloz" <kaloz@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261013120208.11268-4-kaloz@kernel.org>
References: <20261013120208.11268-1-kaloz@kernel.org>
 <20261013120208.11268-4-kaloz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 12:30:16 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> A kickstart or wake-up flag set while its interrupt is enabled (KF with
> KSE, WF with WIE) clears PAB, and the system stays powered. Clear the
> event flags together with setting PAB, and repeat the write until power
> is gone.
>=20
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013120208.1126=
8-1-kaloz@kernel.org?part=3D3

